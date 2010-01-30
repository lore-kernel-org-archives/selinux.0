Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0UHi3tk001942
	for <selinux@tycho.nsa.gov>; Sat, 30 Jan 2010 12:44:03 -0500
Received: from mail.seekline.net (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0UHhtsN006302
	for <selinux@tycho.nsa.gov>; Sat, 30 Jan 2010 17:43:55 GMT
Received: from [192.168.178.25] (95-91-60-83-dynip.superkabel.de [95.91.60.83])
	(authenticated bits=0)
	by mail.seekline.net (8.13.8/8.13.8) with ESMTP id o0UHhvg0024809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Sat, 30 Jan 2010 18:43:58 +0100
Subject: how to trace an avc denial
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 30 Jan 2010 18:43:55 +0100
Message-ID: <1264873435.12042.15.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I'm trying to create a policy for pidgin and hit the following problem:
When pidgin is started via the GNOME menu "Applications -> Internet ->
Pidgin" then I get the following AVC:

type=1400 audit(1264870417.250:22382): avc:  denied  { search } for
pid=9114 comm="pidgin" name="1" dev=proc ino=160141
scontext=unconfined_u:unconfined_r:pidgin_t:s0-s0:c0.c1023
tcontext=system_u:system_r:init_t:s0 tclass=dir
type=1400 audit(1264870417.250:22382): avc:  denied  { read } for
pid=9114 comm="pidgin" name="exe" dev=proc ino=160142
scontext=unconfined_u:unconfined_r:pidgin_t:s0-s0:c0.c1023
tcontext=system_u:system_r:init_t:s0 tclass=lnk_file

At the moment I just don't audit the denials:

require {
        type init_t;
}

dontaudit pidgin_t init_t:dir search;
dontaudit pidgin_t init_t:lnk_file read;

What I would like to do is find out if pidgin itself is
accessing /proc/1/exe or if it is a library. A simple
"grep -R '/proc/' ./pidgin-source" does not provide any helpful output.
My guess is that it is a leaked file descriptor because if I start
pidgin from a shell, then I do not have this problem (I have a rule for
user terminals and so on).

Summarized, how can I find out which library or application part is
causing an AVC? I know there won't be any magical way to find the exact
part ;-) but some general rules or tips would be very appreciated.
Sometimes I use strace, e.g. to find out that a library is doing a call
I'm interested in but this time strace does not help me. So any
comments/suggestions are very welcomed.

cheers,
Stefan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
