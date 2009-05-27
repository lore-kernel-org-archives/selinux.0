Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n4RGg2mh023421
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 12:42:02 -0400
Received: from smtp1.bt.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n4RGftE4005580
	for <selinux@tycho.nsa.gov>; Wed, 27 May 2009 16:41:55 GMT
Message-ID: <4A1D6CDB.5030905@btconnect.com>
Date: Wed, 27 May 2009 17:39:55 +0100
From: Nigel Rumens <wooky@btconnect.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux and sctp
References: <4A191AAC.4000500@btconnect.com> <4A1A7DF6.8080706@redhat.com> <200905261832.44705.paul.moore@hp.com>
In-Reply-To: <200905261832.44705.paul.moore@hp.com>
Content-Type: multipart/alternative;
 boundary="------------080800060103080109050905"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080800060103080109050905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/26/2009 11:32 PM, Paul Moore wrote:
> On Monday 25 May 2009 07:16:06 am Daniel J Walsh wrote:
>    
>> On 05/24/2009 06:00 AM, Nigel Rumens wrote:
>>      
>>> Hi,
>>>
>>> Does selinux understand sctp?
>>>
>>> When I run (for example)
>>>
>>> sctp_darn -H 0 -P 9876 -l
>>>
>>> It results in an avc denial message which tells me the target object is
>>> of type None[rawip_socket]
>>>
>>> Also semanage port -l shows only udp and tcp
>>>
>>> Machine tested on was F11 (fully updated) - I also tried it F10 with the
>>> same results
>>>        
>
> Hi Nigel,
>
> Can you send us the AVC denial messages?  If you are running a recent kernel
> (F11/Rawhide should qualify and F10 will likely as well) there should only be
> a handful of areas where you should be hitting transport protocol specific
> code that isn't SCTP aware in the kernel, it would be nice to verify that so
> we could better identify what work needs to be done.
>
>    

Certainly - here you are.

Summary
SELinux is preventing the sctp_darn (unconfined_t) from binding to port 
9876.
Detailed Description
SELinux has denied the sctp_darn from binding to a network port 9876 
which does not have an SELinux type associated with it. If sctp_darn is 
supposed to be allowed to listen on this port, you can use the semanage 
command to add this port to a port type that unconfined_t can bind to. 
semanage port -l will list all port types. Please file a bug report 
against the selinux-policy package. If sctp_darn is not supposed to bind 
to this port, this could signal a intrusion attempt. If this system is 
running as an NIS Client, turning on the allow_ypbind boolean, may fix 
the problem. setsebool -P allow_ypbind=1.
Allowing Access
If you want to allow sctp_darn to bind to this port semanage port -a -t 
PORT_TYPE -p PROTOCOL 9876 Where PORT_TYPE is a type that unconfined_t 
can bind and PROTOCOL is udp or tcp.
Additional Information
Source Context:      unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
Target Context:      system_u:object_r:port_t:s0
Target Objects:      None [ rawip_socket ]
Source:      sctp_darn
Source Path:      /usr/bin/sctp_darn
Port:      9876
Host:      bear.cwb.uk
Source RPM Packages:      lksctp-tools-1.0.10-1.fc11
Target RPM Packages:
Policy RPM:      selinux-policy-3.6.12-34.fc11
Selinux Enabled:      True
Policy Type:      targeted
MLS Enabled:      True
Enforcing Mode:      Enforcing
Plugin Name:      bind_ports
Host Name:      bear.cwb.uk
Platform:      Linux bear.cwb.uk 2.6.29.3-140.fc11.x86_64 #1 SMP Tue May 
12 10:44:27 EDT 2009 x86_64 x86_64
Alert Count:      1
First Seen:      Fri May 22 07:46:59 2009
Last Seen:      Fri May 22 07:46:59 2009
Local ID:      73919917-a2a5-409c-b29d-1eb84b1acc04
Line Numbers:

Raw Audit Messages :

node=bear.cwb.uk type=AVC msg=audit(1242974819.377:32014): avc: denied { 
name_bind } for pid=14773 comm="sctp_darn" src=9876 
scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 
tcontext=system_u:object_r:port_t:s0 tclass=rawip_socket
node=bear.cwb.uk type=SYSCALL msg=audit(1242974819.377:32014): 
arch=c000003e syscall=49 success=no exit=-13 a0=3 a1=7fff08b0bdd0 a2=10 
a3=7fff08b0bdc0 items=0 ppid=14732 pid=14773 auid=500 uid=500 gid=500 
euid=500 suid=500 fsuid=500 egid=500 sgid=500 fsgid=500 tty=pts2 ses=51 
comm="sctp_darn" exe="/usr/bin/sctp_darn" 
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)

--------------080800060103080109050905
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
On 05/26/2009 11:32 PM, Paul Moore wrote:
<blockquote cite="mid:200905261832.44705.paul.moore@hp.com" type="cite">
  <pre wrap="">On Monday 25 May 2009 07:16:06 am Daniel J Walsh wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On 05/24/2009 06:00 AM, Nigel Rumens wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Hi,

Does selinux understand sctp?

When I run (for example)

sctp_darn -H 0 -P 9876 -l

It results in an avc denial message which tells me the target object is
of type None[rawip_socket]

Also semanage port -l shows only udp and tcp

Machine tested on was F11 (fully updated) - I also tried it F10 with the
same results
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
Hi Nigel,

Can you send us the AVC denial messages?  If you are running a recent kernel 
(F11/Rawhide should qualify and F10 will likely as well) there should only be 
a handful of areas where you should be hitting transport protocol specific 
code that isn't SCTP aware in the kernel, it would be nice to verify that so 
we could better identify what work needs to be done.

  </pre>
</blockquote>
<br>
Certainly - here you are.<br>
<br>
Summary<br>
SELinux is preventing the sctp_darn (unconfined_t) from binding to port
9876.<br>
Detailed Description<br>
SELinux has denied the sctp_darn from binding to a network port 9876
which does not have an SELinux type associated with it. If sctp_darn is
supposed to be allowed to listen on this port, you can use the semanage
command to add this port to a port type that unconfined_t can bind to.
semanage port -l will list all port types. Please file a bug report
against the selinux-policy package. If sctp_darn is not supposed to
bind to this port, this could signal a intrusion attempt. If this
system is running as an NIS Client, turning on the allow_ypbind
boolean, may fix the problem. setsebool -P allow_ypbind=1.<br>
Allowing Access<br>
If you want to allow sctp_darn to bind to this port semanage port -a -t
PORT_TYPE -p PROTOCOL 9876 Where PORT_TYPE is a type that unconfined_t
can bind and PROTOCOL is udp or tcp.<br>
Additional Information<br>
Source Context:&nbsp; &nbsp;&nbsp;&nbsp;
unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023<br>
Target Context:&nbsp; &nbsp;&nbsp;&nbsp; system_u:object_r:port_t:s0<br>
Target Objects:&nbsp; &nbsp;&nbsp;&nbsp; None [ rawip_socket ]<br>
Source:&nbsp; &nbsp;&nbsp;&nbsp; sctp_darn<br>
Source Path:&nbsp; &nbsp;&nbsp;&nbsp; /usr/bin/sctp_darn<br>
Port:&nbsp; &nbsp;&nbsp;&nbsp; 9876<br>
Host:&nbsp; &nbsp;&nbsp;&nbsp; bear.cwb.uk<br>
Source RPM Packages:&nbsp; &nbsp;&nbsp;&nbsp; lksctp-tools-1.0.10-1.fc11<br>
Target RPM Packages:&nbsp; &nbsp;&nbsp;&nbsp; <br>
Policy RPM:&nbsp; &nbsp;&nbsp;&nbsp; selinux-policy-3.6.12-34.fc11<br>
Selinux Enabled:&nbsp; &nbsp;&nbsp;&nbsp; True<br>
Policy Type:&nbsp; &nbsp;&nbsp;&nbsp; targeted<br>
MLS Enabled:&nbsp; &nbsp;&nbsp;&nbsp; True<br>
Enforcing Mode:&nbsp; &nbsp;&nbsp;&nbsp; Enforcing<br>
Plugin Name:&nbsp; &nbsp;&nbsp;&nbsp; bind_ports<br>
Host Name:&nbsp; &nbsp;&nbsp;&nbsp; bear.cwb.uk<br>
Platform:&nbsp; &nbsp;&nbsp;&nbsp; Linux bear.cwb.uk 2.6.29.3-140.fc11.x86_64 #1 SMP Tue
May 12 10:44:27 EDT 2009 x86_64 x86_64<br>
Alert Count:&nbsp; &nbsp;&nbsp;&nbsp; 1<br>
First Seen:&nbsp; &nbsp;&nbsp;&nbsp; Fri May 22 07:46:59 2009<br>
Last Seen:&nbsp; &nbsp;&nbsp;&nbsp; Fri May 22 07:46:59 2009<br>
Local ID:&nbsp; &nbsp;&nbsp;&nbsp; 73919917-a2a5-409c-b29d-1eb84b1acc04<br>
Line Numbers:&nbsp; &nbsp;&nbsp;&nbsp; <br>
<br>
Raw Audit Messages :<br>
<br>
node=bear.cwb.uk type=AVC msg=audit(1242974819.377:32014): avc: denied
{ name_bind } for pid=14773 comm="sctp_darn" src=9876
scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
tcontext=system_u:object_r:port_t:s0 tclass=rawip_socket<br>
node=bear.cwb.uk type=SYSCALL msg=audit(1242974819.377:32014):
arch=c000003e syscall=49 success=no exit=-13 a0=3 a1=7fff08b0bdd0 a2=10
a3=7fff08b0bdc0 items=0 ppid=14732 pid=14773 auid=500 uid=500 gid=500
euid=500 suid=500 fsuid=500 egid=500 sgid=500 fsgid=500 tty=pts2 ses=51
comm="sctp_darn" exe="/usr/bin/sctp_darn"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null) <br>
</body>
</html>

--------------080800060103080109050905--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
