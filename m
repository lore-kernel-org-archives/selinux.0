Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1KFb4dW013971
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 10:37:04 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1KFWlli021796
	for <selinux@tycho.nsa.gov>; Sun, 20 Feb 2005 15:32:47 GMT
Date: Sun, 20 Feb 2005 15:44:58 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
Subject: Re: Java Legacy problem
Message-ID: <20050220154458.GH14038@lkcl.net>
References: <1108910713.3610.18.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108910713.3610.18.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

if i was dealing with it, i would create a macro - mozilla_java_domain
with an argument $1 which takes the role (see usage of mozilla_domain).

it'd create a type mozilla_java_$1_t which would then
have things like this:

uses_shlib($1)

which would get rid of most of the things you list, below, as a
start, and then you could move on to the _next_ lot :)

the key bit is to then identify which program is being
run which gets you _into_ that domain so that you can
do a domain_auto_trans(), something like this:

domain_auto_trans($1_mozilla_t, java_program_thing_exec_t,
			mozilla_java_$1_t)


the $1_mozilla_t i _assume_ is what mozilla gets executed
in, looking at macros/program/mozilla_macros.te.

if so, and _assuming_ it executes a program
/usr/java/j2re1.4.2_05/bin/java which will need to be given
a context java_program_thing_exec_t _then_ you will
end up executing that program in mozilla_java_user_t
(or whatever - mozilla_java_sysadm_t if you're mad enough).


if of course mozilla doesn't bother to exec the program
/usr/java/..../bin/java, and instead does something stupid
like load the java libraries itself, then of course you're in
trouble because you'd need to modify mozilla to use the new
setcon() dynamic transition thing, in which case, good luck.

l.

On Sun, Feb 20, 2005 at 09:45:13AM -0500, Ivan Gyurdiev wrote:
> Hi, 
> 
> As previously discussed on this list, Java does not work properly. 
> It's a legacy domain that produces all kinds of execmod/execute denials.
> Stephen Smalley suggested that it be placed in its own domain.
> 
> Daniel Walsh's Java policy, however, only works for the Mozilla plugin.
> I think the argument was that a Java policy would have to permit most
> things in the user domain.
> 
> So, what is the recommended strategy for dealing with Java, so
> that those denials will go away?
> 
> user_t (java):
> denied { execute } ld_so_cache_t:file (/etc/ld.so.cache) 
> denied { execute } locale_t:file      (/usr/lib/locale/locale-archive)
> denied { execmod } shlib_t:file       (/lib/libc-2.3.4.so)
> denied { execmod } ld_so_t:file       (/lib/ld-2.3.4.so)
> 
> 
> -- 
> Ivan Gyurdiev <ivg2@cornell.edu>
> Cornell University
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
