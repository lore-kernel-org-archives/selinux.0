Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1QJn7C9007507
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 14:49:07 -0500
Received: from ns1.a61.nl (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1QJn6QG002576
	for <selinux@tycho.nsa.gov>; Tue, 26 Feb 2008 19:49:06 GMT
Date: Tue, 26 Feb 2008 19:55:24 +0100
Subject: Re: Global requirements were not met
From: Ronald van den Blink <selinux@a61.nl>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: <selinux@tycho.nsa.gov>
Message-ID: <C3EA1F2C.299B%selinux@a61.nl>
In-Reply-To: <1204049658.32061.189.camel@gorn>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On [DATE], "[NAME]" <[ADDRESS]> wrote:

> On Tue, 2008-02-26 at 17:06 +0100, selinux@a61.nl wrote:
>> Still having problems setting up modules dor JBoss + Java:
>> 
>> I believe our JBoss module has a fine start now. We decided to write a
>> complete new java-module (jbossjava) so we will be able to get java to
>> work is strict-mode.
>> 
>> See the following files:
>> myjboss.if: http://pastebin.com/f4df202a2
>> myjboss.te: http://pastebin.com/d7318637b
>> myjboss.fc: http://pastebin.com/f2f66ff68
>> 
>> jbossjava.if: http://pastebin.com/f179749e8
>> jbossjava.te: http://pastebin.com/f1731b45d
>> jbossjava.fc: http://pastebin.com/f52227f13
> [...]
>>    1:selinux-policy-strict  ########################################### [
>> 33%]
>> libsepol.print_missing_requirements: jbossjava's global requirements were
>> not met: type/attribute jboss_rx_t
>> libsemanage.semanage_link_sandbox: Link packages failed
>> semodule:  Failed!
> [...]
>> Apparently, jbossjava doesn't have any access to the interfaces in
>> myjboss.pp. why?
> 
> Its not an interface problem, jboss_rx_t isn't declared.

If I look in the myjboss.if file I see:


interface(`jboss_rx_files',`
        gen_require(`
                type jboss_rx_t;
        ')
        allow $1 jboss_rx_t:file exec_file_perms;
')

If I understand the interfaces right it is declared in the gen_require
statement? And then we can use it in jbossjava.te:

jboss_rx_files(jbossjava_t)

Or do we not understand the way interfaces work? Do we have to declare
jboss_rx_t in jbossjava.te also?





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
