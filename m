Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAQEUjRb019739
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 09:30:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAQEUiqY005490
	for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 14:30:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hAQEUi0o005487 for <selinux@tycho.nsa.gov>; Wed, 26 Nov 2003 14:30:44 GMT
Subject: Re: Type attributes
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <3FC4ADF3.2050509@ipen.br>
References: <3FC4ADF3.2050509@ipen.br>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1069857041.30315.72.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 26 Nov 2003 09:30:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-11-26 at 08:43, Carlos Anísio Monteiro wrote:
> The type attributes are used only as identifier to SELinux or to 
> administrator of the SELinux. As the type attributes is optional not 
> have needed of declare them. Then, can I pass over ? or I am not 
> undertanding them right.

I'm not sure I understand your question.  A type attribute in a policy
rule is expanded to the set of types that have that attribute.  Are you
asking:
1) Whether a type attribute name needs to be declared before using it in
a type declaration?
Answer:  Yes.  At one time, type attribute names were implicitly
declared upon their first use in a type declaration, but explicit
declarations were added and required to allow the compiler to catch
mistakes.  Type attribute names are typically declared in attrib.te.
2) Whether a type declaration must have type attributes associated with
it?
Answer:  No.  However, if you define a new type and it does fit into one
of the existing attribute definitions (see the comments in attrib.te),
then you should associate that attribute with it unless you have a
specific reason not to do so.  For example, if you define a new type for
a process, and you fail to associate the 'domain' attribute with it,
then many existing allow rules that use 'domain' will not be applied to
it, which could be a problem for normal system operation (e.g. init
needs to be able to reap it, administrators should be able to kill it,
etc).  Also, you may end up violation an assertion if you fail to use
the attribute, as assertions are often based on attributes.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
