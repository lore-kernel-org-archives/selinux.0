Message-ID: <SNT139-w519F82649003961764FE6DABC30@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_18eb62e2-a619-4fe4-a7cd-601a2cdcac3b_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <eparis@redhat.com>, Stephen Smalley <sds@tycho.nsa.gov>
CC: <jmorris@namei.org>, <eparis@parisplace.org>,
        selinux-mailing-list
	<selinux@tycho.nsa.gov>,
        <qingtao.cao@windriver.com>
Subject: RE: [v2 PATCH 3/3] SELinux: Compute SID for the newly created socket
Date: Thu, 3 Mar 2011 02:25:48 +0000
In-Reply-To: <1299095534.15533.24.camel@localhost.localdomain>
References: 
 <1299043954-21877-2-git-send-email-qingtao.cao@windriver.com>,<1299043954-21877-3-git-send-email-qingtao.cao@windriver.com>,<1299074314.23615.5.camel@moss-pluto>,<1299095534.15533.24.camel@localhost.localdomain>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_18eb62e2-a619-4fe4-a7cd-601a2cdcac3b_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Many thanks Eric and Stephen! I am downloading Eric's selinux git tree now.

Any further comments or questions just let me know.

Best regards,
Harry

> Subject: Re: [v2 PATCH 3/3] SELinux: Compute SID for the newly created socket
> From: eparis@redhat.com
> To: sds@tycho.nsa.gov
> CC: qingtao.cao@windriver.com; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov
> Date: Wed, 2 Mar 2011 14:52:12 -0500
> 
> On Wed, 2011-03-02 at 08:58 -0500, Stephen Smalley wrote:
> > On Wed, 2011-03-02 at 13:32 +0800, Harry Ciao wrote:
> > > The security context for the newly created socket shares the same
> > > user, role and MLS attribute as its creator but may have a different
> > > type, which could be specified by a type_transition rule in the relevant
> > > policy package.
> > > 
> > > Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> > 
> > The patches look good to me but I think they conflict with already
> > applied patches in Eric's tree:
> > git clone git://git.infradead.org/users/eparis/selinux.git
> > 
> >  CC      security/selinux/hooks.o
> > security/selinux/hooks.c: In function ¡®socket_sockcreate_sid¡¯:
> > security/selinux/hooks.c:3602:2: warning: passing argument 4 of
> > ¡®security_transition_sid¡¯ from incompatible pointer type
> > security/selinux/include/security.h:111:5: note: expected ¡®const struct
> > qstr *¡¯ but argument is of type ¡®u32 *¡¯
> > security/selinux/hooks.c:3602:2: error: too few arguments to function
> > ¡®security_transition_sid¡¯
> > security/selinux/include/security.h:111:5: note: declared here
> > security/selinux/hooks.c:3603:1: warning: control reaches end of
> > non-void function
> > make[2]: *** [security/selinux/hooks.o] Error 1
> > 
> > I think Eric changed the security_transition_sid interface to support
> > type_transitions based on last component name, so you'd need to adjust
> > your patches accordingly.
> > 
> > Patches for SELinux now go in via Eric's tree and then on to James'
> > tree.
> 
> I actually fixed up your patch and pushed them to a new branch for
> review.  If people are happy I will merge them and send them along
> towards Linus.
> 
> http://git.infradead.org/users/eparis/selinux.git/shortlog/refs/heads/socket-labeling
> 
> -Eric
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_18eb62e2-a619-4fe4-a7cd-601a2cdcac3b_
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
<body class='hmmessage'>
Many thanks Eric and Stephen! I am downloading Eric's selinux git tree now.<br><br>Any further comments or questions just let me know.<br><br>Best regards,<br>Harry<br><br>&gt; Subject: Re: [v2 PATCH 3/3] SELinux: Compute SID for the newly created socket<br>&gt; From: eparis@redhat.com<br>&gt; To: sds@tycho.nsa.gov<br>&gt; CC: qingtao.cao@windriver.com; jmorris@namei.org; eparis@parisplace.org; selinux@tycho.nsa.gov<br>&gt; Date: Wed, 2 Mar 2011 14:52:12 -0500<br>&gt; <br>&gt; On Wed, 2011-03-02 at 08:58 -0500, Stephen Smalley wrote:<br>&gt; &gt; On Wed, 2011-03-02 at 13:32 +0800, Harry Ciao wrote:<br>&gt; &gt; &gt; The security context for the newly created socket shares the same<br>&gt; &gt; &gt; user, role and MLS attribute as its creator but may have a different<br>&gt; &gt; &gt; type, which could be specified by a type_transition rule in the relevant<br>&gt; &gt; &gt; policy package.<br>&gt; &gt; &gt; <br>&gt; &gt; &gt; Signed-off-by: Harry Ciao &lt;qingtao.cao@windrive!
 r.com&gt;<br>&gt; &gt; <br>&gt; &gt; The patches look good to me but I think they conflict with already<br>&gt; &gt; applied patches in Eric's tree:<br>&gt; &gt; git clone git://git.infradead.org/users/eparis/selinux.git<br>&gt; &gt; <br>&gt; &gt;  CC      security/selinux/hooks.o<br>&gt; &gt; security/selinux/hooks.c: In function ¡®socket_sockcreate_sid¡¯:<br>&gt; &gt; security/selinux/hooks.c:3602:2: warning: passing argument 4 of<br>&gt; &gt; ¡®security_transition_sid¡¯ from incompatible pointer type<br>&gt; &gt; security/selinux/include/security.h:111:5: note: expected ¡®const struct<br>&gt; &gt; qstr *¡¯ but argument is of type ¡®u32 *¡¯<br>&gt; &gt; security/selinux/hooks.c:3602:2: error: too few arguments to function<br>&gt; &gt; ¡®security_transition_sid¡¯<br>&gt; &gt; security/selinux/include/security.h:111:5: note: declared here<br>&gt; &gt; security/selinux/hooks.c:3603:1: warning: control reaches end of<br>&gt; &gt; non-void function<br>&gt; &gt; make[2]: *** [s!
 ecurity/selinux/hooks.o] Error 1<br>&gt; &gt; <br>&gt; &gt; I think Er
ic changed the security_transition_sid interface to support<br>&gt; &gt; type_transitions based on last component name, so you'd need to adjust<br>&gt; &gt; your patches accordingly.<br>&gt; &gt; <br>&gt; &gt; Patches for SELinux now go in via Eric's tree and then on to James'<br>&gt; &gt; tree.<br>&gt; <br>&gt; I actually fixed up your patch and pushed them to a new branch for<br>&gt; review.  If people are happy I will merge them and send them along<br>&gt; towards Linus.<br>&gt; <br>&gt; http://git.infradead.org/users/eparis/selinux.git/shortlog/refs/heads/socket-labeling<br>&gt; <br>&gt; -Eric<br>&gt; <br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscribers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br> 		 	   		  </body>
</html>
--_18eb62e2-a619-4fe4-a7cd-601a2cdcac3b_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
