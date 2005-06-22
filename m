Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5M1vagA013179
	for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2005 21:57:36 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5M1lWK0010785
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 01:47:32 GMT
Message-Id: <200506220148.j5M1ltqc008740@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'antoine'" <antoine@nagafix.co.uk>,
   "=?iso-8859-1?Q?'Lorenzo_Hern=E1ndez_Garc=EDa-Hierro'?=" <lorenzo@gnu.org>
Cc: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
   "'Colin Walters'" <walters@verbum.org>,
   "'SELinux Mail List'" <selinux@tycho.nsa.gov>
Subject: RE: ANN: SELinux Reference Policy Release
Date: Tue, 21 Jun 2005 21:47:56 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <1119396349.9416.50.camel@localhost>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of antoine
> Sent: Tuesday, June 21, 2005 7:26 PM
> To: Lorenzo Hernández García-Hierro
> Cc: Christopher J. PeBenito; Colin Walters; SELinux Mail List
> Subject: Re: ANN: SELinux Reference Policy Release
> 
> > El jue, 16-06-2005 a las 09:55 -0400, Christopher J. PeBenito escribió:
> > > We did look into other available formats for machine parseable comments,
> > > and XML is really the best choice if you want the comments to be
> > > transformed into many different formats, and easily loaded into other
> > > programs; its already well understood, and parsers exist for many
> > > programming languages.  Simpler (for humans to read) commenting formats
> > > just don't have these options, and mainly target one transformation.
> As long as that transformation is the XML one, we are ok. Just an extra
> step needed when using the XML data which should not be a problem.
> 
> > A modified Gnome-doc (ie. Kernel-doc) might be an interesting option.
> > It would be a matter of modifying the lex and other stuff to make it
> > parsing our own commenting style within the policy files.
> Yes. How about using a more human-readable format *with* the ability to
> generate the long-winded XML from it so we get the benefit of both?
> I am not just suggesting this for someone else to do, if you think this
> is worth doing I would be willing to write the code myself.
> 

See below for my thoughts on the format. If you are interested in helping we
would be happy for any contributions. The sf cvs is updated nightly. We should
get what we view as the task list up on the website soon and welcome any
suggestions for what should be accomplished in the near or long term. 

> Example:
> /**
>   * @interface selinux_get_enforce_mode
>   * @description Allows the caller to get the mode of policy enforcement
>   *         (enforcing or permissive mode).
>   * @param domain The process type to allow to get the enforcing mode.
>   */
> Could easily be translated to the XML that was given as example:
> ########################################
> ## <interface name="selinux_get_enforce_mode">
> ##      <description>
> ##              Allows the caller to get the mode of policy enforcement
> ##              (Allows the caller to get the mode of policy enforcement > ##
</description>
> ##      <parameter name="domain">
> ##              The process type to allow to get the enforcing mode.
> ##      </parameter>
> ## </interface>
> #
> Now which one do you prefer?
> I am not against XML on principle (I have used SGML/XML since 1995) just
> trying to keep things human readable as much as possible.

I think that we can make this more readable without punting on the xml (which I
actually think is easier to read than the javadoc style @ tags). We are going to
trim down the XML to look more like:

## 
## <description>
##	Allows the caller to get the mode of policy enforcement
## </description>
##
## <param name="domain">
## 	The process type to allow to get the enforcing mode.
## </param>
##

That means that the interface name will be derived from the actual interface
declaration, which should probably be changed to a macro for declaring
interfaces. The final xml file that is output won't change, we will just
generate some of the tags. Thoughts?

> We could also the use the @return notation to show which domains are
> created by the macro:
> @return mydomain_tmp_t, mydomain_var_t, etc
> 

Reference policy macros _never_ create types. A macro that defines a new type 1)
breaks encapsulation and 2) means that the policy author has to muck around in
either the docs or the implementation to figure out what types were created.

> > We have some Java code lying around that can parse the generated XML
> > if you want it. We are also working on an eclipse based policy
> > development environment.
> Is there any code publicly available?
> 

Not yet - if you want the parsing code I can release it though.

Karl

> Antoine
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
