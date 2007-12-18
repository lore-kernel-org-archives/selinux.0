Subject: Re: Propper labeling of files under /var/www
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1198003507.3705.15.camel@localhost6.localdomain6>
References: <1198003507.3705.15.camel@localhost6.localdomain6>
Content-Type: text/plain
Date: Tue, 18 Dec 2007 13:55:34 -0500
Message-Id: <1198004134.11568.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-12-18 at 18:45 +0000, Stefan Schulze Frielinghaus wrote:
> How do you label files under /var/www? I created a policy with the
> following context
> 
> /var/www/wiki(/.*)?
> gen_context(system_u:object_r:httpd_wiki_script_ro_t,s0)
> 
> Loaded the policy and relabeled /var/www but the context
> of /var/www/wiki is still httpd_sys_content_t. Checked the
> file /etc/selinux/targeted/contexts/files/file_contexts twice and the
> entry for /var/www/wiki exists (it's under the /var/www entry). The
> relabel was done via fixfiles and restorecon and even a reboot
> (touch /.autorelabel).
> 
> I'm out of ideas ;-) Any suggestions?
> 
> Best regards
> Stefan
> 
> PS: I'm using Fedora 7 (latest updates) with the targeted policy
> (2.6.4-61.fc7)

Try restorecon -FRv /var/www

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
