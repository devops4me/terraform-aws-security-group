
/*
 | --
 | -- This list of security group rules can be overriden and you can provide
 | -- your own rule port number mappings.
 | --
*/
variable rules {

    type = map( list( string ) )

    default = {
        "ssh"         = [ "22", "22", "tcp", "secure shell" ]
        "https"       = [ "443", "443", "tcp",   "http secured" ]
        "http"        = [ "80",  "80", "tcp", "http plaintext" ]
        "all-traffic" = [ "-1", "-1",    "-1",   "All protocols" ]
        "ecs"         = [ "32768", "61000", "tcp",   "cluster comms" ]
        "docker"      = [ "5000",   "5000", "tcp", "docker registry" ]
        "java"        = [ "8080", "8080", "tcp", "java port"     ]
        "jenkins"     = [ "8080", "8080", "tcp", "jenkins ci"    ]
        "sonar"       = [ "9000", "9000", "tcp", "sonarqube metrics" ]
        "postgres"    = [  "5432",  "5432", "tcp",  "postgresql db" ]
    }
}
