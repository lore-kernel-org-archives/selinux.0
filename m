Subject: Re: I am add a custom rule, know how 2 do te file, what about fc
	file, please help
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Rongdong Lu <qdmudong@hotmail.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux@tycho.nsa.gov
In-Reply-To: <BAY22-F25ADF3AA0F5941B05A0CA3C0DD0@phx.gbl>
References: <BAY22-F25ADF3AA0F5941B05A0CA3C0DD0@phx.gbl>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 14:09:52 -0500
Message-Id: <1143486592.22696.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-03-26 at 01:38 +0000, Rongdong Lu wrote:
> Hi, List,
> 
> Selinux has been driving me real crazy for the last serveral weeks, now 
> finally I'am getting some clue.
> 
> Here's a problem i am having now. I have a centos4 server, with selinux 
> turned on, I can't use php to send out mail. I am using 
> selinux-policy-targeted-1.17.30-2.126. I am trying to add a custom rule the 
> first time.
> 
> here is the error messge in messages log:
> 
> Mar 25 20:19:14 example kernel: audit(1143335954.882:36): avc:  denied  { 
> execute } for  pid=10036 comm="sh" name="sendmail" dev=sda5 ino=1228853 
> scontext=root:system_r:httpd_sys_script_t tcontext=system_u:object_r:var_t 
> tclass=file
> Mar 25 20:19:14 example kernel: audit(1143335954.882:37): avc:  denied  { 
> getattr } for  pid=10036 comm="sh" name="sendmail" dev=sda5 ino=1228853 
> scontext=root:system_r:httpd_sys_script_t tcontext=system_u:object_r:var_t 
> tclass=file
> 
> I know I can use audit2allow to get the rule to add in to a te file, but 
> what do I add to the fc file? I couldn't find which is the command trys to 
> access sendmail, a process with that pid one didn't exist after the error 
> message is generated.
> 
> any advice is appeciated, thanks in advance, guys

What does 'ls -Z /usr/bin/sendmail.sendmail' show?

You only need to create/modify a .fc file if you want to alter the file
security contexts.  The policy Makefile will complain if you create
a .te file under domains/program without a matching .fc file over in
file_contexts/program, but you can create arbitary .te files under
domains/misc without creating any matching .fc file.

BTW, simply allowing the above is likely not what you want, but I'm not
sure what options exist in centos systems for proper policy for sendmail
et al (without switching to strict policy), or if they have a boolean
for this case.  I think similar questions have been asked in the past on
fedora-selinux-list about php and mail.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
