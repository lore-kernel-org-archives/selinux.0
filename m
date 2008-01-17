Subject: Re: newrole -l error
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30801161448kd990a86h35b1c664439f4488@mail.gmail.com>
References: <dd18b0c30801161448kd990a86h35b1c664439f4488@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 17 Jan 2008 10:46:40 -0500
Message-Id: <1200584800.7025.42.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-16 at 14:48 -0800, Justin Mattock wrote:
> Hello does anybody have a fix for newrole -l s? Error: you are not
> allowed to change levels on a non secure terminal;
> I'm using refpolicy-20071214 from tresys, my build.config has  mls
> monolithic enabled. 

All you have to do is create
an /etc/selinux/$SELINUXTYPE/contexts/securetty_types file with your
favorite editor and put the type of your tty into it, as others have
told you previously.  

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
