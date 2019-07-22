
# -- ############################ -- #
# -- How to Add New Traffic Rules -- #
# -- ############################ -- #

# -- In order to add new rules be informed that 
# --
# --    - lists are in the form [ port-from, port-to, protocol, description ]
# --    - the first two elements are integers and the final two are strings
# --    - it pays to be conservative with the description characters and length
# --    - ports can range from 0 to one less than 2^16 (which is 65,535)
# --    - a -1 port signals that all ports are to be allowed (disallowed)
# --    - the protocol can be one of [ tcp, udp, icmp, all ]
# --    - the protocol can also be one of a small set of numbers

# -- Note that if you create an all traffic egress rule and you have an
# -- IPV6 Cidr block another will be created to ::/0 in addition to the
# -- one with the 0.0.0.0/0 (IPV4) notation.

variable rules {
  type = object({
    http = list(string)
    all-traffic = list(string)
    ecs = list(string)
    docker = list(string)
    java = list(string)
    jenkins = list(string)
    sonar = list(string)
    postgres = list(string)
  })
}


locals {
  rules = {
        http  = [  80,  80, "tcp", "http plaintext" ]
        all-traffic   = [ -1, -1,    "-1",   "All protocols" ]
        ecs          = [ 32768, 61000, "tcp",   "cluster comms" ]
        docker       = [ 5000,   5000, "tcp", "docker registry" ]
        java    = [ 8080, 8080, "tcp", "java port"     ]
        jenkins = [ 8080, 8080, "tcp", "jenkins ci"    ]
        sonar   = [ 9000, 9000, "tcp", "sonarqube metrics" ]
        postgres   = [  5432,  5432, "tcp",  "postgresql db" ]
  }
}


/*
variable rules {

    description = "Modular rules allowing either TCP or UDP traffic."
    type = any

    default = {

	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ the most common traffic types ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        ssh = [ 22, 22, "tcp", "secure shell" ]
        http  = [  80,  80, "tcp", "http plaintext" ]
        https = [ 443, 443, "tcp",   "http secured" ]
        ahttp = [ 8888, 8888, "tcp", "alternate http" ]


	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ Rules for all ports & protocols ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        all-traffic   = [ -1, -1,    "-1",   "All protocols" ]
        all-tcp       = [ 0,  65535, "tcp",  "All TCP ports" ]
        all-udp       = [ 0,  65535, "udp",  "All UDP ports" ]
        all-icmp      = [ -1, -1,    "icmp", "All IPV4 ICMP" ]
        all-ipv6-icmp = [ -1, -1,    58,     "All IPV6 ICMP" ]


	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ message queue related protocols ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        rmq-admin = [  15672,  15672, "tcp", "rabbitmq admin cli"  ]
        rmq-tls   = [  25672,  25672, "tcp", "rabbitmq admin tls"  ]
        rmq-comms = [  35672,  35682, "tcp", "rabbit comm ports"   ]
        amqp      = [  5672,   5672,  "tcp", "msg queue protocol"  ]
        amqp-tls  = [  5671,   5671,  "tcp", "msg queue secure"    ]
        epmd      = [  4369,   4369,  "tcp", "erlang port mapper"  ]
        stomp     = [  61613,  61613, "tcp", "stomp plain text"    ]
        stomp-tls = [  61614,  61614, "tcp", "stomp secure ssl"    ]
        mqtt      = [  1883,   1883,  "tcp", "mq series telemetry" ]


	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ Containerized Services Suite ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        kubernetes   = [  6443,  6443, "tcp",  "kubernetes api" ]
        kubelet-api  = [ 10250, 10250, "tcp",     "kubelet api" ]
        kube-sched   = [ 10251, 10251, "tcp",  "kube scheduler" ]
        kube-control = [ 10252, 10252, "tcp", "kube controller" ]
        kube-read    = [ 10255, 10255, "tcp",  "kube read only" ]
        ecs          = [ 32768, 61000, "tcp",   "cluster comms" ]
        docker       = [ 5000,   5000, "tcp", "docker registry" ]


	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ etcd client server api ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        etcd-client = [ 2379, 2379, "tcp", "etcd client" ]
        etcd-server = [ 2380, 2380, "tcp", "etcd server" ]
        etcd-listen = [ 4001, 4001, "tcp", "etcd listen" ]


	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ logging and elasticsearch stack tools ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        fluentd = [ 24224, 24224, "tcp", "fluentd logs"  ]
        kibana  = [ 5601,  5601,  "tcp", "kibana portal" ]
        elastic = [ 9200,  9200,  "tcp", "elasticsearch" ]


	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ Java EcoSystem Tooling ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        java    = [ 8080, 8080, "tcp", "java port"     ]
        tomcat  = [ 8080, 8080, "tcp", "tomcat server" ]
        jenkins = [ 8080, 8080, "tcp", "jenkins ci"    ]
        hudson  = [ 8080, 8080, "tcp", "hudson ci"     ]
        nexus   = [ 8080, 8080, "tcp", "nexus dir"     ]
        sonar   = [ 9000, 9000, "tcp", "sonarqube metrics" ]


	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ gollum's webrick http server ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        gollum = [ 4567, 4567, "tcp", "gollum wiki" ]


	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ Database Management Systems ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        postgres   = [  5432,  5432, "tcp",  "postgresql db" ]


    }

}
*/
