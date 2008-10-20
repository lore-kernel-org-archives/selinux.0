Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9K8ws43014473
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 04:58:54 -0400
Received: from mailhost.cdltd.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9K8wl80029820
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 08:58:54 GMT
Received: from exch.cdltd.co.uk (fw.cdltd.co.uk [193.132.127.247])
	by mailhost.cdltd.co.uk (8.14.1/8.12.11) with ESMTP id m9K8rb3A031334
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2008 09:56:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: SELinux blocking disclaimer - help diagnosing
Date: Mon, 20 Oct 2008 09:56:17 +0100
Message-ID: <DAE2574A7F44F44ABE07381C36213DFA05C05720@exch.cdltd.co.uk>
From: "Paul Cocker" <paul.cocker@tntpost.co.uk>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm attaching a footer to e-mail in postfix using altermime. SELinux is
preventing this from happening.
 
I did some reading and have thus been using the method of switching
SELinux into permissible mode, sending an e-mail through the system,
then using audit2allow to generate a policy from the audit log generated
by the e-mail.

grep AVC /var/log/audit/audit.log | audit2allow -m altermime >
altermime.te
checkmodule -mM -o altermime.mod altermime.te
semodule_package -o altermime.pp -m altermime.mod
semodule -i altermime.pp

I use semodule -l to verify the policy was loaded.
 
Once I enable SELinux and send another e-mail I find the e-mail is still
stopped, so I run audit2allow again and it picks up a type that wasn't
in the previous policy (I remove the > altermime.te bit and manually
move over the missing bits), so I update the module and add it to
SELinux. I repeat this process a couple of times as the e-mail is
blocked by new things.
 
However, the e-mail is still blocked and running audit2allow on the log
shows no changes over the existing policy.

Postfix is sending the following error to the sender:

user@domain2.com: service unavailable.
Command output: mime_alter.c:2192:AM_insert_Xheader:NOTICE: Adjusting
temp file name for header insert sendmail: fatal: execvp
/usr/sbin/postdrop: Permission denied
sendmail: warning: premature end-of-input on /usr/sbin/postdrop -r while
reading input attribute name sendmail: warning: command
"/usr/sbin/postdrop -r" exited with status 1 sendmail: fatal:
user@domain.com(100): unable to execute /usr/sbin/postdrop -r: Success
 
Contents of the maillog for this message:

Oct 20 09:26:21 merlin postfix/smtpd[16322]: C95801F80042:
client=computer.domain.com[10.100.100.100]
Oct 20 09:26:21 merlin postfix/cleanup[16324]: C95801F80042:
message-id=<01c9328d$Blat.v2.6.2$88778715$6f8d393e538@10.100.100.200>
Oct 20 09:26:21 merlin postfix/qmgr[16156]: C95801F80042:
from=<user@domain2.com>, size=562, nrcpt=1 (queue active)
Oct 20 09:26:21 merlin postfix/smtpd[16322]: disconnect from
computer.domain.com[10.100.100.100]
Oct 20 09:26:21 merlin sendmail[16330]: fatal: execvp
/usr/sbin/postdrop: Permission denied
Oct 20 09:26:22 merlin postfix/sendmail[16329]: warning: premature
end-of-input on /usr/sbin/postdrop -r while reading input attribute name
Oct 20 09:26:22 merlin postfix/sendmail[16329]: warning: command
"/usr/sbin/postdrop -r" exited with status 1
Oct 20 09:26:22 merlin postfix/sendmail[16329]: fatal:
user@domain2.com(100): unable to execute /usr/sbin/postdrop -r: Success
Oct 20 09:26:23 merlin postfix/pipe[16325]: C95801F80042:
to=<user@domain.com>, relay=dfilt, delay=2, delays=0.01/0/0/2,
dsn=5.3.0, status=bounced (service unavailable. Command output:
mime_alter.c:2192:AM_insert_Xheader:NOTICE: Adjusting temp file name for
header insert sendmail: fatal: execvp /usr/sbin/postdrop: Permission
denied sendmail: warning: premature end-of-input on /usr/sbin/postdrop
-r while reading input attribute name sendmail: warning: command
"/usr/sbin/postdrop -r" exited with status 1 sendmail: fatal:
user@domain2.com(100): unable to execute /usr/sbin/postdrop -r: Success
)
Oct 20 09:26:23 merlin postfix/cleanup[16324]: D027D1F8007B:
message-id=<20081020082623.D027D1F8007B@mailserver.domain.com>
Oct 20 09:26:23 merlin postfix/bounce[16332]: C95801F80042: sender
non-delivery notification: D027D1F8007B
Oct 20 09:26:23 merlin postfix/qmgr[16156]: D027D1F8007B: from=<>,
size=3216, nrcpt=1 (queue active)
Oct 20 09:26:23 merlin postfix/qmgr[16156]: C95801F80042: removed
Oct 20 09:26:23 merlin postfix/smtp[16333]: D027D1F8007B:
to=<user@domain2.com>, relay=relay.domain.com[10.100.100.1]:25,
delay=0.11, delays=0/0/0/0.1, dsn=2.6.0, status=sent (250 2.6.0
<20081020082623.D027D1F8007B@mailserver.domain.com> Queued mail for
delivery)
Oct 20 09:26:23 merlin postfix/qmgr[16156]: D027D1F8007B: removed

The policy generated looks as follows:
 
module altermime 1.0;
 
require {
        type postfix_etc_t;
        type postfix_public_t;
        type postfix_spool_t;
        type sendmail_exec_t;
        type postfix_pipe_t;
        type postfix_spool_maildrop_t;
        class sock_file write;
        class dir { write search remove_name add_name };
        class file { rename execute read create execute_no_trans unlink
};
        class process setrlimit;
}
 
#============= postfix_pipe_t ==============
allow postfix_pipe_t postfix_etc_t:file { execute execute_no_trans };
allow postfix_pipe_t postfix_public_t:sock_file write;
allow postfix_pipe_t postfix_spool_maildrop_t:dir { write remove_name
search add_name };
allow postfix_pipe_t postfix_spool_t:dir { write remove_name add_name };
allow postfix_pipe_t postfix_spool_t:file { create rename unlink };
allow postfix_pipe_t sendmail_exec_t:file { read execute
execute_no_trans };
allow postfix_pipe_t self:process setrlimit;

Being new to SELinux I'm stumbling around in the dark somewhat (and if
someone can tell me what the self:process line is I'd be grateful). I'm
guessing that the following line is the problem:

fatal: execvp /usr/sbin/postdrop: Permission denied

The security context of this file is
system_u:object_r:postfix_postdrop_exec_t

I'm thinking that perhaps I need to add:

type postfix_postdrop_exec_t
allow postfix_pipe_t postfix_postdrop_exec_t:file execute

However, can anyone tell me why this error isn't generating new content
in audit.log? Is my next step the right one?

I think the above policy is swiss-cheesing my postfix security :/ Alas,
I don't have much of a choice on this one, this is the only way to add
footers to postfix that I have found, plus the box runs other services
too so I don't want to disable SELinux. Anyway, disabling security
systems is always a step in the wrong direction IMO, better to have the
short-term pain.

Paul Cocker



TNT Post is the trading name for TNT Post UK Ltd (company number: 04417047), TNT Post (Doordrop Media) Ltd (00613278), TNT Post Scotland Ltd (05695897), TNT Post North Ltd (05701709), TNT Post South West Ltd (05983401), TNT Post Midlands Limited (6458167)and TNT Post London Limited (6493826). Emma's Diary and Lifecycle are trading names for Lifecycle Marketing (Mother and Baby) Ltd (02556692). All companies are registered in England and Wales; registered address: 1 Globeside Business Park, Fieldhouse Lane, Marlow, Buckinghamshire, SL7 1HY.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
