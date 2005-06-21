Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5LNZSgA012306
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 19:35:28 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5LNPPK0003812
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 23:25:25 GMT
Subject: Re: ANN: SELinux Reference Policy Release
From: antoine <antoine@nagafix.co.uk>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1118943983.8987.23.camel@localhost.localdomain>
References: <1118871745.18294.28.camel@sgc.columbia.tresys.com>
	 <1118874951.24338.35.camel@nexus.verbum.private>
	 <1118877949.10103.19.camel@localhost>
	 <1118930113.18294.56.camel@sgc.columbia.tresys.com>
	 <1118943983.8987.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 22 Jun 2005 00:25:49 +0100
Message-Id: <1119396349.9416.50.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> El jue, 16-06-2005 a las 09:55 -0400, Christopher J. PeBenito escribió:
> > We did look into other available formats for machine parseable comments,
> > and XML is really the best choice if you want the comments to be
> > transformed into many different formats, and easily loaded into other
> > programs; its already well understood, and parsers exist for many
> > programming languages.  Simpler (for humans to read) commenting formats
> > just don't have these options, and mainly target one transformation.
As long as that transformation is the XML one, we are ok. Just an extra
step needed when using the XML data which should not be a problem.

> A modified Gnome-doc (ie. Kernel-doc) might be an interesting option.
> It would be a matter of modifying the lex and other stuff to make it
> parsing our own commenting style within the policy files.
Yes. How about using a more human-readable format *with* the ability to
generate the long-winded XML from it so we get the benefit of both?
I am not just suggesting this for someone else to do, if you think this
is worth doing I would be willing to write the code myself.

Example:
/**
  * @interface selinux_get_enforce_mode
  * @description Allows the caller to get the mode of policy enforcement
  *         (enforcing or permissive mode).
  * @param domain The process type to allow to get the enforcing mode.
  */
Could easily be translated to the XML that was given as example:
########################################
## <interface name="selinux_get_enforce_mode">
##      <description>
##              Allows the caller to get the mode of policy enforcement
##              (enforcing or permissive mode).
##      </description>
##      <parameter name="domain">
##              The process type to allow to get the enforcing mode.
##      </parameter>
## </interface>
#
Now which one do you prefer?
I am not against XML on principle (I have used SGML/XML since 1995) just
trying to keep things human readable as much as possible.
We could also the use the @return notation to show which domains are
created by the macro:
@return mydomain_tmp_t, mydomain_var_t, etc

> We have some Java code lying around that can parse the generated XML
> if you want it. We are also working on an eclipse based policy
> development environment.
Is there any code publicly available?

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
