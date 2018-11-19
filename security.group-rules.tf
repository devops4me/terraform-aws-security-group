
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

variable "rules"
{
    description = "Modular rules allowing either TCP or UDP traffic."
    type = "map"

    default
    {

	# < ~~~ ~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ ssh secure shell ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~ ~~~ >
        ssh = [ 22, 22, "tcp", "secure shell" ]

	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ http(s) - hyper text transfer protocol ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        http  = [  80,  80, "tcp", "http plaintext" ]
        https = [ 443, 443, "tcp",   "http secured" ]

	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ gollum's webrick http server ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        gollum = [ 4567, 4567, "tcp", "gollum wiki" ]

	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ Kubernetes Services Suite ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        kubernetes   = [  6443,  6443, "tcp",  "kubernetes api" ]
        kubelet-api  = [ 10250, 10250, "tcp",     "kubelet api" ]
        kube-sched   = [ 10251, 10251, "tcp",  "kube scheduler" ]
        kube-control = [ 10252, 10252, "tcp", "kube controller" ]
        kube-read    = [ 10255, 10255, "tcp",  "kube read only" ]

	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ etcd client server api ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        etcd-client = [ 2379, 2379, "tcp", "etcd client" ]
        etcd-server = [ 2380, 2380, "tcp", "etcd server" ]
        etcd-listen = [ 4001, 4001, "tcp", "etcd listen" ]


        # -- ElasticSearch (ELK) Stack Rules
	# -- Remember that ElasticSearch (ELK stack) can require up
	# -- to 3 extra inbound ports for the JAVA API (9300), then
	# -- the HTTP (80) and HTTPS (443) for the Kibana UI.

        elasticsearch = [ 9200, 9200, "tcp", "elasticsearch" ]


        # -- Java services traditionally employ port 8080
	# -- (tomcat, jenkins, nexus, jserve ...)

        java = [ 8080, 8080, "tcp", "HTTP" ]


	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ Rules for all ports & protocols ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        all-traffic   = [ -1, -1,    "-1",   "All protocols" ]
        all-tcp       = [ 0,  65535, "tcp",  "All TCP ports" ]
        all-udp       = [ 0,  65535, "udp",  "All UDP ports" ]
        all-icmp      = [ -1, -1,    "icmp", "All IPV4 ICMP" ]
        all-ipv6-icmp = [ -1, -1,    58,     "All IPV6 ICMP" ]


	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
	# < ~~~ rabbitmq and related protocols ~~~ >
	# < ~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ~~~ >
        rabbitmq     = [  15672,  15672, "tcp",     "rabbitmq admin cli" ]
        rabbitmq-tls = [  25672,  25672, "tcp",     "rabbitmq admin tls" ]
        amqp         = [  5672,   5672,  "tcp", "message queue protocol" ]
        amqp-tls     = [  5671,   5671,  "tcp",   "message queue secure" ]
        stomp        = [  61613,  61613, "tcp",      "STOMP without tls" ]
        stomp-tls    = [  61614,  61614, "tcp",         "STOMP with tls" ]
        erlang-pmd   = [  4369,   4369,  "tcp",     "erlang port mapper" ]
        mqtt         = [  1883,   1883,  "tcp",    "mq series telemetry" ]


    }

}
