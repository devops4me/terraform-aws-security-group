
/*
 | --
 | -- Return the ID of the rule aggregating security goup bucket.
 | --
*/
output out_security_group_id {

    description = "The string ID of either the default security group or the just created new one."
    value       = aws_security_group.new.id
}
