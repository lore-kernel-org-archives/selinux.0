Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3O8gs9j022252
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 04:42:54 -0400
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3O8grNE029967
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 08:42:53 GMT
Date: Thu, 24 Apr 2008 10:42:52 +0200
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy: domains need access to the apt's pty and fifos
Message-ID: <20080424084252.GA24667@bobek.pm.i.cz>
References: <200803062117.20441.russell@coker.com.au> <1204805640.5885.4.camel@hepcat.vitavonni.de> <20080305152322.GA9988@bobek.pm.i.cz> <1204734268.12784.124.camel@hepcat.vitavonni.de> <200803062117.20441.russell@coker.com.au> <20080305152322.GA9988@bobek.pm.i.cz> <1204734268.12784.124.camel@hepcat.vitavonni.de> <20080321073158.GA12456@bobek.pm.i.cz> <1206547029.16113.272.camel@gorn> <20080423103042.GE14827@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <20080423103042.GE14827@bobek.pm.i.cz>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Apr 23, 2008 at 12:30:42PM +0200, Václav Ovsík wrote:
...
> Thanks for the exhaustive explanation Christopher. It seemed to me, that
> your idea can be done at least for types (a roleattribute keyword not
> exist yet), but I was wrong about attributes :(. Attribute can't have
> attribute (recursively). With an attached nonfunctional patch I ended
> with:
> 
> /usr/bin/checkmodule -M -m tmp/apt.tmp -o tmp/apt.mod
> /usr/bin/checkmodule:  loading policy configuration from tmp/apt.tmp
> policy/modules/admin/apt.te":135:ERROR 'unknown type dpkg_inherited_fd' at token ';' on line 7686:
>         typeattribute dpkg_inherited_fd apt_inherited_fd;
> #line 135
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> make: *** [tmp/apt.mod] Error 1
> 
> Of course dpkg_inherited_fd is the attribute and not the type, shame.
> You are right, with current policy language this can't be done easily.
> 
> Maybe wee can do this job using m4. This would require an additional
> pass to process sources or modification of processing a bit. My rough
> idea for modular policy:
>     * To include the third new parameter of interface/template macro
>       used by run interfaces. This parameter will accept what and how
>       should be inherited in some notation parse able fine by m4. The
>       information "what" should describe the class (fd, pipe...), the
>       type. The information "how" should describe passing down (to pass
>       inheritance down or to stop inheritance there).
>     * To split module preprocessing (m4) and compilation (checkmodule)
>       (Rules.modular).
>     * All modules must by m4 processed at first to create the
>       meta-information about all inheritances. The compilation
>       (checkmodule) of any module (with some run interface) should
>       depend on meta-information from all other packages.
>     * Updating of inheritance meta-information must be updated only when
>       the content is really different, so Make will not restart
>       rebuilding things unnecessarily.
>     * To build allow rules from inheritance meta-information and append
>       this rules to already preprocessed .te product and compile it by
>       checkmodule.
...

I see at least one flaw - the policy build in such a way will be
somewhat "static" concerning adding modules into pre-build policy. That
is when someone will take policy headers and compile an own local
module, then all other pre-build modules affected by inheritance will be
obsolete. So, there is no improvement in this area against current
state.

The only benefit from the proposal is, that policy sources will be a bit
more clean (I hope) and ready for introducing inheritance in the policy
language (I hope only macros and processing will need change).

Best Regards
-- 
Zito

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
