From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Greger" <boss@gregerhaga.net>
Subject: Re: how to enable se linux for my app?
Date: Sat, 10 Feb 2007 19:19:13 +1100
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Michael C Thompson <thompsmc@us.ibm.com>, selinux@tycho.nsa.gov
References: <20070209185428.M24608@gregerhaga.net> <1171053598.4975.28.camel@moss-spartans.epoch.ncsc.mil> <20070209223449.M45949@gregerhaga.net>
In-Reply-To: <20070209223449.M45949@gregerhaga.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702101919.15884.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 10 February 2007 09:36, "Greger" <boss@gregerhaga.net> wrote:
> Feb 10 02:35:41 localhost kernel: audit(1171067741.422:18): avc:  denied  {
> execmod } for  pid=29429 comm="x" name="libqxrssapp.so" dev=dm-0
> ino=2588491 scontext=user_u:system_r:unconfined_t:s0
> tcontext=user_u:object_r:user_home_t:s0 tclass=file
>
> qxrssapp is a library taht the application uses, the app is made of six
> libraries plus the main func in the executable.

http://etbe.blogspot.com/2007/02/execmod.html

Your shared object needs to be compiled with -fpic or -fPIC.  The command 
eu-findtextrel can be used to discover which functions were compiled 
incorrectly.  See the above URL for more information.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
