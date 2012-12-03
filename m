Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB3EMIx2025431
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2012 09:22:18 -0500
Received: from sander.oxilion (kantoor.oxilion.nl [93.186.176.113])
	by vds-1069.hoentjen.eu (Postfix) with ESMTPSA id 179A1E11DA
	for <selinux@tycho.nsa.gov>; Mon,  3 Dec 2012 15:22:09 +0100 (CET)
Message-ID: <50BCB590.8010602@hoentjen.eu>
Date: Mon, 03 Dec 2012 15:22:08 +0100
From: Sander Hoentjen <sander@hoentjen.eu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: policy for PowerDNS
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I had created a policy for PowerDNS (pdns package in Fedora), but after 
e-mailing with dwalsh he told me it might be better to just adapt the 
named policy a bit. Here is what I have so far:
======pdns.fc======
/usr/sbin/pdns_server  -- gen_context(system_u:object_r:named_exec_t,s0)
/etc/pdns/pdns.conf    -- gen_context(system_u:object_r:named_conf_t,s0)
/var/run/pdns.controlsocket -s 
gen_context(system_u:object_r:named_var_run_t,s0)
/var/run/pdns.pid   -- gen_context(system_u:object_r:named_var_run_t,s0)
===================
======pdns.te======
policy_module(pdns,0.0.1)

require{
     type named_t;
}

#gmysql backend:
bool pdns_can_connect_db true;
tunable_policy(`pdns_backend_mysql', `
     mysql_read_config(named_t)
     #socket
     mysql_stream_connect(named_t)
')
===================
With this added pdns works with both the bind-backend and the 
mysql-backend (pdns-backend-mysql in Fedora). I do still get some 
denials, first 2 with both backends:
type=AVC msg=audit(12/03/2012 14:30:26.767:597) : avc:  denied  { fsetid 
} for  pid=23063 comm=pdns_server capability=fsetid 
scontext=system_u:system_r:named_t:s0 
tcontext=system_u:system_r:named_t:s0 tclass=capability

type=AVC msg=audit(12/03/2012 14:30:26.735:595) : avc:  denied  { kill } 
for  pid=20597 comm=pdns_server capability=kill 
scontext=system_u:system_r:named_t:s0 
tcontext=system_u:system_r:named_t:s0 tclass=capability

For this I can add:
allow named_t self:capability { fsetid kill };
but I am not sure if that is okay, can anyone please advise?

Last one I get with the mysql backend:
type=AVC msg=audit(12/03/2012 13:37:52.315:545) : avc:  denied  { 
getattr } for  pid=20772 comm=pdns_server 
path=/usr/share/mysql/charsets/Index.xml dev="dm-0" ino=8936 
scontext=system_u:system_r:named_t:s0 
tcontext=system_u:object_r:usr_t:s0 tclass=file
To allow this I will have to allow read access from named_t to usr_t, 
would that be okay?

Kind regards,

Sander

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
