Message-ID: <SNT139-W640BE6F3829A2C5D982BDDAB210@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_3123d378-2fbd-47c7-bbef-9e7cfe12bc6c_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <sds@tycho.nsa.gov>, <russell@coker.com.au>
CC: <dwalsh@redhat.com>, <selinux@tycho.nsa.gov>
Subject: RE: checkpolicy is broken (which is not)
Date: Mon, 8 Aug 2011 06:41:37 +0000
In-Reply-To: <1312561259.19283.76.camel@moss-pluto>
References: 
 <4E3AEA75.3090602@redhat.com>,<1312550851.19283.35.camel@moss-pluto>
 <4E3C0152.7000105@redhat.com>,<201108060130.49464.russell@coker.com.au>,<1312561259.19283.76.camel@moss-pluto>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_3123d378-2fbd-47c7-bbef-9e7cfe12bc6c_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Stephen,

> Subject: Re: checkpolicy is broken (which is not)
> From: sds@tycho.nsa.gov
> To: russell@coker.com.au
> CC: dwalsh@redhat.com; selinux@tycho.nsa.gov
> Date: Fri, 5 Aug 2011 12:20:59 -0400
> 
> On Sat, 2011-08-06 at 01:30 +1000, Russell Coker wrote:
> > I think that the ideal situation for a Debian upgrade (which can and usually 
> > is done in stages unlike a RHEL upgrade) is to support either the old policy 
> > with new user-space or the new policy with the old user-space.  Ideally this 
> > would also include the ability to rebuild the policy packages from source.
> 
> I'm not sure how you could support the latter, as newer policy sources
> will use the language features supported by the latest checkpolicy, and
> thus often won't be compilable by an older checkpolicy.  The former is
> possible, but requires us to preserve the present ambiguity between
> declaring a role and adding types to an existing role.
> 
> > In regard to the "role httpd_t types httpd_t;" corner case, aren't there a 
> > heap of other corner cases where someone can accidentally write policy that 
> > doesn't do what they expect?
> 
> Certainly, but I think the notion was to provide the same level of
> compile-time checking of roles as we presently get for types.  Users
> would be the last remaining holdout at that point; like roles, we
> allowed multiple declarations when we decomposed the policy into
> per-domain source modules, introducing ambiguity between declaration and
> use.  We had a somewhat similar issue for type attributes, where they
> were originally defined implicitly on first use in a type declaration,
> and then later we added explicit attribute declarations and required
> their use to avoid similar mistakes.
> 

I have not understood this question as deep as others :-P

As for removing above "ambiguity between declaration and use", so it would be desirable to remove the association between a regular type and type attributes in the current type-attribute rule, and shrink it to some "type" rule only for type declaration, and request policy writers to setup the association explicitly via the typeattribute rule. 

Also we should handle roles in a similar way: use some "role" rule solely for role declaration and "attribute_role" rule for role attribute declaration, then "roleattribute" rule for setting up their associations.

Is that right?

Also this would introduce significant change to the original type-attribute rule, how would it be easier for the community to accept such change?

Thanks!

Best regards,
Harry


> > What about the macros for things like r_file_perms?  How long are we going to 
> > keep that around?  We've already had a couple of releases with the new 
> > version.
> 
> -- 
> Stephen Smalley
> National Security Agency
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_3123d378-2fbd-47c7-bbef-9e7cfe12bc6c_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'><div dir='ltr'>
Hi Stephen,<br><br><div>&gt; Subject: Re: checkpolicy is broken (which is not)<br>&gt; From: sds@tycho.nsa.gov<br>&gt; To: russell@coker.com.au<br>&gt; CC: dwalsh@redhat.com; selinux@tycho.nsa.gov<br>&gt; Date: Fri, 5 Aug 2011 12:20:59 -0400<br>&gt; <br>&gt; On Sat, 2011-08-06 at 01:30 +1000, Russell Coker wrote:<br>&gt; &gt; I think that the ideal situation for a Debian upgrade (which can and usually <br>&gt; &gt; is done in stages unlike a RHEL upgrade) is to support either the old policy <br>&gt; &gt; with new user-space or the new policy with the old user-space.  Ideally this <br>&gt; &gt; would also include the ability to rebuild the policy packages from source.<br>&gt; <br>&gt; I'm not sure how you could support the latter, as newer policy sources<br>&gt; will use the language features supported by the latest checkpolicy, and<br>&gt; thus often won't be compilable by an older checkpolicy.  The former is<br>&gt; possible, but requires us to preserve the present ambiguit!
 y between<br>&gt; declaring a role and adding types to an existing role.<br>&gt; <br>&gt; &gt; In regard to the "role httpd_t types httpd_t;" corner case, aren't there a <br>&gt; &gt; heap of other corner cases where someone can accidentally write policy that <br>&gt; &gt; doesn't do what they expect?<br>&gt; <br>&gt; Certainly, but I think the notion was to provide the same level of<br>&gt; compile-time checking of roles as we presently get for types.  Users<br>&gt; would be the last remaining holdout at that point; like roles, we<br>&gt; allowed multiple declarations when we decomposed the policy into<br>&gt; per-domain source modules, introducing ambiguity between declaration and<br>&gt; use.  We had a somewhat similar issue for type attributes, where they<br>&gt; were originally defined implicitly on first use in a type declaration,<br>&gt; and then later we added explicit attribute declarations and required<br>&gt; their use to avoid similar mistakes.<br>&gt; <br><br>I!
  have not understood this question as deep as others :-P<br><br>As for
 removing above "ambiguity between declaration and use", so it would be desirable to remove the association between a regular type and type attributes in the current type-attribute rule, and shrink it to some "type" rule only for type declaration, and request policy writers to setup the association explicitly via the typeattribute rule. <br><br>Also we should handle roles in a similar way: use some "role" rule solely for role declaration and "attribute_role" rule for role attribute declaration, then "roleattribute" rule for setting up their associations.<br><br>Is that right?<br><br>Also this would introduce significant change to the original type-attribute rule, how would it be easier for the community to accept such change?<br><br>Thanks!<br><br>Best regards,<br>Harry<br><br><br>&gt; &gt; What about the macros for things like r_file_perms?  How long are we going to <br>&gt; &gt; keep that around?  We've already had a couple of releases with the new <br>&gt; &gt; version.<b!
 r>&gt; <br>&gt; -- <br>&gt; Stephen Smalley<br>&gt; National Security Agency<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </div></body>
</html>
--_3123d378-2fbd-47c7-bbef-9e7cfe12bc6c_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
