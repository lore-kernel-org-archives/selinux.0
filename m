Subject: Re: questions about policy for webmin
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: lky <lky77@sjtu.edu.cn>
Cc: SELINUX <SELinux@tycho.nsa.gov>
In-Reply-To: <005501c3913b$3eaeffe0$5d38a8c0@lky>
References: <005501c3913b$3eaeffe0$5d38a8c0@lky>
Content-Type: text/plain
Message-Id: <1066143595.5054.176.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 14 Oct 2003 10:59:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-10-12 at 23:36, lky wrote:
> I have installed SELinux on Redhat9.0. Then I installed webmin to
> configure the system remotely. As there are no policy for webmin(as
> least I didn't find any .te or .fc files for webmin) so webmin run
> within the initrc_t domain.My questions are:
> 1.what will happen or what's the disadvantage if the webmin run within
> the initrc_t domain?
> 2.Can I add webmin program to an existing domain?
> 3.If I want to write a policy for webmin, which program policy can I
> used for reference, ssh.te or any others? Because I found it's so hard
> for me to write a policy.

You seem to be reposting the same questions repeatedly, and this even
after Russell Coker has replied to you on the list.

Leaving webmin in the initrc_t domain is unwise, as initrc_t has many
permissions to perform system initialization.  If you are running webmin
via apache, then the apache policy is a possible starting point.  If
not, then you may want to create your own domain from scratch, starting
with the daemon_domain() macro.

Note that SELinux can only provide limited benefit for webmin, as it
would appear to require administrative privileges anyway...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
