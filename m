Subject: Re: trouble with execmod permission in file class
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mario Fanelli <mario.fanelli@gmail.com>
Cc: SeLinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <447c043c.0e9fa353.26b4.ffffa66e@mx.gmail.com>
References: <447c043c.0e9fa353.26b4.ffffa66e@mx.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 30 May 2006 11:16:10 -0400
Message-Id: <1149002170.524.44.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-30 at 10:37 +0200, Mario Fanelli wrote:
> I’m trying to write a policy for apache and audit2allow suggest me a
> rule like
> 
>  
> 
> allow apache_t lib_t:file execmod
> 
>  
> 
> but I don’t understand..
> 
> I read on tresys.com that permission execmod -> “Make executable a
> file mapping that has been modified by copy-on-write”.
> 
> Anyone can give me an explanation? Why, without this rule, apache
> doesn’t load module?

http://people.redhat.com/drepper/selinux-mem.html
http://www.nsa.gov/selinux/papers/module/x1407.html
http://fedora.redhat.com/docs/selinux-faq-fc5/#faq-entry-unconfined_t

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
