Message-ID: <416419A5.6030809@redhat.com>
Date: Wed, 06 Oct 2004 12:13:25 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Shouldn't this avc message be dontaudited?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

How come I am getting this avc message

Oct  6 11:58:44 localhost kernel: audit(1097078324.850:0): avc:  denied  
{ name_bind } for  pid=2471 exe=/usr/sbin/nscd src=953 
scontext=user_u:system_r:nscd_t tcontext=system_u:object_r:rndc_port_t 
tclass=tcp_socket

When I have this rule?

dontaudit nscd_t reserved_port_t:{ tcp_socket udp_socket } name_bind;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
