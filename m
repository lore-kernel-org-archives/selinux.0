Subject: Re: Help with SELinux policy for Usability Study
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Cliffe <cliffe@ii.net>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
        slide@tresys.com
In-Reply-To: <4A711890.2030101@ii.net>
References: <200907300352.n6U3qvAC012682@tarius.tycho.ncsc.mil>
	 <4A711890.2030101@ii.net>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 30 Jul 2009 08:02:38 -0400
Message-Id: <1248955358.11627.91.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-30 at 11:50 +0800, Cliffe wrote:
> Dear SELinux Gurus,
> 
> I am a PhD candidate conducting research into the usability of security 
> mechanisms. I would really appreciate some help regarding the use of 
> SELinux. Let me know if this is not the right place to be asking these 
> types of questions.

General usability questions, yes.  polgengui however is Fedora-specific
and thus fedora-selinux-list may be a more suitable choice.

You should also take a look at SLIDE, an Eclipse plugin for creating
SELinux policies.  The upstream home page is at:
http://oss.tresys.com/projects/slide/
and the software should be available in Fedora via:
yum install eclipse-slide

> I generated a policy for opera using polgengui. I then ran the generated 
> ./opera.sh.
> 
> Although SELinux was still set to enforcing mode opera seemed to run 
> unconfined. The executable and process was labelled as expected 
> (unconfined_u:unconfined_r:opera_t). AVCs were generated, but not enforced.
> 
> I added to opera.te using
> grep opera /var/log/audit/audit.log | audit2allow >> opera.te
> and reran ./opera.sh
> until no AVCs were generated.
> 
> Looking at opera.te I noticed the line “permissive opera_t”, and not 
> knowing exactly what this line does, I thought it may be placing this 
> domain into permissive mode (although the gui tools suggest otherwise). 
> Removing the line causes “/bin/sh: /usr/bin/opera: Permission denied”. 
> No AVCs are generated.

Yes, permissive opera_t causes the domain to run in permissive mode
while leaving the rest of the system enforcing.  Per-domain permissive
mode was introduced in Fedora 10, I think.

> So I am not sure why opera seams to be unconfined, or if removing the 
> permissive line was on the right track. Any advice?

Yes, removing the permissive line is the right track to take when you
are ready to test in enforcing mode.  If you don't see any AVC denials,
then try running semodule -DB to strip all dontaudit rules from policy
and then re-test, followed by semodule -B again to restore the dontaudit
rules.  This will generate a _lot_ of denials, some of which are
irrelevant, but should then show you all denials.  dontaudit rules are
used to suppress denials that come from harmless application or library
probing (e.g. getcwd) that are not required for operation of the
application, but may sometimes mask real denials.

I'm not sure why polgengui is automatically adding a permissive line in
this case but not in the case of kwrite - Dan?  It should be consistent,
and it really only should do that with user consent as the user needs to
know that the domain is permissive. 

> Also I tried creating a policy for kwrite. This time the created policy 
> seemed to be in effect as soon as I ran the kwrite.sh script. I set 
> setenforce 0 and added to kwrite.te (as above for opera) until no error 
> msgs were generated. Then I reran ./kwrite.sh. Now kwrite exists with 
> “kwrite(2533): Couldn’t register name ‘”org.kate-editor.kwrite-2533’” 
> with DBUS – another process owns it already!”. When setenforce 0 it runs 
> without AVCs.

Sounds like you are getting a DBUS denial, so look for USER_AVC messages
e.g.
/sbin/ausearch -i -m USER_AVC

> Again I am sure I am missing something simple and your advice will help 
> a lot.
> 
> I need to resolve this asap and will really appreciate any advice.
> 
> Soon I will be running a comparative study comparing a number of 
> security mechanisms and I need to sort this out.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
