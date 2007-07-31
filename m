Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6VLeNYq013083
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 17:40:23 -0400
Received: from rv-out-0910.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6VLeMM8018846
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 21:40:23 GMT
Received: by rv-out-0910.google.com with SMTP id k20so6990rvb
        for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2007 14:40:22 -0700 (PDT)
Message-ID: <7b740b700707311440u1b1c1261n139e19ace911437b@mail.gmail.com>
Date: Wed, 1 Aug 2007 02:40:22 +0500
From: "shahbaz khan" <shazalive@gmail.com>
To: "Joshua Brindle" <method@manicmethod.com>, selinux@tycho.nsa.gov
Subject: Re: PMS and SELinux
In-Reply-To: <46AFA076.7090904@manicmethod.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8425_7888899.1185918022023"
References: <7b740b700707301225q4aa45498yb61f12af17be0d95@mail.gmail.com>
	 <46AFA076.7090904@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_8425_7888899.1185918022023
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/1/07, Joshua Brindle <method@manicmethod.com> wrote:
>
> shahbaz khan wrote:
> > I would like to ask a few questions from the experts regarding some
> > implementations. I am working on a survey on selinux rsbac and
> > grsecurity. Got some from mailing lists but need more. References will
> > be appreciated.. They are the following:
> >
> >
> >    1. What is a security aware application. What functionality it can
> >       provide? Has this functionality been provide in the other
> >       competitors.
> >
> a security aware application, in SELinux, is an application that
> utilizes the userspace interface to the security server. That is, it
> requests security decisions that are fulfilled by the kernelspace or
> userspace security server based on the policy loaded into the security
> server.


What is the difference between kernel space and user space security server?

>    1. Where are sids implemented. I have heard that they are history
> >       now. How are they opaque to object managers?
> >
> sids are only used in the kernel now, as a way to avoid dealing with
> memory lifespans on structs containing a security field (and also to
> save memory by only having one copy of each context, in the sidtab)
>
> >    1. What difference has PMS brought to selinux. Do we have such in
> >       other implementations?
> >
> it is still in a prototype phase so in terms of practical benefits it is
> pretty minimal, for now. It does allow one to control updates to the
> policy though, and hopefully will be ready for widespead deployment at
> some point in the near future. Other implementations (eg., rsbac,
> grsecurity) do not have fine grained access control on policy updates,
> implementations such as trusted extensions on solaris have a static BLP
> policy and therefore have no policy updates.
>
> >    1. How is PMS implemented? Any technical documents? Is it a secure
> >       application using the extended api?
> >
> There are a few fairly high level documents on selinux-symposium.org,
> and some others on oss.tresys.com/projects/policy-server. Since the
> object model changed fairly in the last implementation of the policy
> server the technical documents on the object model are currently out of
> date, we should be updating them at some point though.
>
> >    1. How and where is AVC implemented?
> >
> the AVC is used by object managers (both kernel and userspace) to make
> access decision lookups faster, there is an implementation in the kernel
> (security/selinux/avc.c) and in libselinux (libselinux/src/avc.c)


So we can say that it is partially implemented in both spaces!?

>    1. Is there any good logging facility apart from regular denial? I
> >       have heard rsbac and grsecurity has better logging facilities.
> >
> SELinux utilizes the in-kernel auditing framework, we don't want to
> confuse auditing and security policy enforcement (though we do have
> auditallow functionality), more fine grained auditing on specific
> syscalls, etc can be accomplished with the audit framework (see man
> auditctl)
>
> >    1. SELinux uses syscall interception. Is it through LSM? How does
> >       rsbac and grsecurity manage this?
> >
> There is no syscall interception, LSM is more abstract than the syscall
> layer. rsbac and grsecurity both implement their own hook systems that
> are similar (both different enough that they aren't satisfied with LSM).


What terminology can be used if not interception? Looking at the
architecture it denies or allows a syscall when call is made. The check is
made on the inode and types for process and inode is taken into account
through the hook.

Any information about grsec's and rsbac's hook implementations? They lack a
great deal of documentation!

>    1. Of the topic but how does grsecurity implement acls and rbac. Is
> >       rbac used through the acls or a seperate module?
> >
> probably the best place to ask detailed questions about grsecurity's acl
> implementation is on their list.


They have'nt replied yet.

>    1. How can we best judge the network controls of rsbac and
> >       grsecurity w.r.t. implementation, usability and functionality?
> >
> grsec and rsbac both use network controls similar to the old selinux
> controls, where we limited access to specific ports, network interfaces,
> etc. SELinux now uses a netfilter based system where we apply labels to
> packets based on any netfilter criteria (port, interface, remote node,
> connection tracking, anything iptables can filter on) and we allow
> access based on the label of a particular packet. We also have 2
> implementations of labeled networking, which isn't available in rsbac or
> grsec.
>
> > I will be glad to put the names of responders in my survey document's
> > acknowledgements.
> >
> No need.


I insist. An honor for me. I do not like to show off with someone elses
intellect and hardwork.

------=_Part_8425_7888899.1185918022023
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div><span class="gmail_quote">On 8/1/07, <b class="gmail_sendername">Joshua Brindle</b> &lt;<a href="mailto:method@manicmethod.com">method@manicmethod.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">shahbaz khan wrote:<br>&gt; I would like to ask a few questions from the experts regarding some<br>&gt; implementations. I am working on a survey on selinux rsbac and
<br>&gt; grsecurity. Got some from mailing lists but need more. References will<br>&gt; be appreciated.. They are the following:<br>&gt;<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. What is a security aware application. What functionality it can
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; provide? Has this functionality been provide in the other<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; competitors.<br>&gt;<br>a security aware application, in SELinux, is an application that<br>utilizes the userspace interface to the security server. That is, it
<br>requests security decisions that are fulfilled by the kernelspace or<br>userspace security server based on the policy loaded into the security<br>server.</blockquote>
<div>&nbsp;</div>
<div>What is the difference between&nbsp;kernel space and user space security server?</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. Where are sids implemented. I have heard that they are history<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; now. How are they opaque to object managers?
<br>&gt;<br>sids are only used in the kernel now, as a way to avoid dealing with<br>memory lifespans on structs containing a security field (and also to<br>save memory by only having one copy of each context, in the sidtab)
<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. What difference has PMS brought to selinux. Do we have such in<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; other implementations?<br>&gt;<br>it is still in a prototype phase so in terms of practical benefits it is<br>pretty minimal, for now. It does allow one to control updates to the
<br>policy though, and hopefully will be ready for widespead deployment at<br>some point in the near future. Other implementations (eg., rsbac,<br>grsecurity) do not have fine grained access control on policy updates,<br>
implementations such as trusted extensions on solaris have a static BLP<br>policy and therefore have no policy updates.<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. How is PMS implemented? Any technical documents? Is it a secure<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; application using the extended api?
<br>&gt;<br>There are a few fairly high level documents on <a href="http://selinux-symposium.org">selinux-symposium.org</a>,<br>and some others on <a href="http://oss.tresys.com/projects/policy-server">oss.tresys.com/projects/policy-server
</a>. Since the<br>object model changed fairly in the last implementation of the policy<br>server the technical documents on the object model are currently out of<br>date, we should be updating them at some point though.<br>
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. How and where is AVC implemented?<br>&gt;<br>the AVC is used by object managers (both kernel and userspace) to make<br>access decision lookups faster, there is an implementation in the kernel<br>(security/selinux/avc.c) and in libselinux (libselinux/src/avc.c)
</blockquote>
<div>&nbsp;</div>
<div>So we can say that it is partially implemented in both spaces!?</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. Is there any good logging facility apart from regular denial? I<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; have heard rsbac and grsecurity has better logging facilities.
<br>&gt;<br>SELinux utilizes the in-kernel auditing framework, we don&#39;t want to<br>confuse auditing and security policy enforcement (though we do have<br>auditallow functionality), more fine grained auditing on specific
<br>syscalls, etc can be accomplished with the audit framework (see man<br>auditctl)<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. SELinux uses syscall interception. Is it through LSM? How does<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rsbac and grsecurity manage this?<br>&gt;
<br>There is no syscall interception, LSM is more abstract than the syscall<br>layer. rsbac and grsecurity both implement their own hook systems that<br>are similar (both different enough that they aren&#39;t satisfied with LSM).
</blockquote>
<div>&nbsp;</div>
<div>What terminology can be used if not interception? Looking at the architecture it denies or allows a syscall when call is made. The check is made on the inode and types for process and inode is taken into account through the hook.
</div>
<div>&nbsp;</div>
<div>Any information about&nbsp;grsec&#39;s and rsbac&#39;s&nbsp;hook implementations? They lack a great deal of documentation!</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. Of the topic but how does grsecurity implement acls and rbac. Is<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rbac used through the acls or a seperate module?
<br>&gt;<br>probably the best place to ask detailed questions about grsecurity&#39;s acl<br>implementation is on their list.</blockquote>
<div>&nbsp;</div>
<div>They have&#39;nt replied yet.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt;&nbsp;&nbsp;&nbsp;&nbsp;1. How can we best judge the network controls of rsbac and<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; grsecurity w.r.t. implementation, usability and functionality?
<br>&gt;<br>grsec and rsbac both use network controls similar to the old selinux<br>controls, where we limited access to specific ports, network interfaces,<br>etc. SELinux now uses a netfilter based system where we apply labels to
<br>packets based on any netfilter criteria (port, interface, remote node,<br>connection tracking, anything iptables can filter on) and we allow<br>access based on the label of a particular packet. We also have 2<br>implementations of labeled networking, which isn&#39;t available in rsbac or
<br>grsec.<br><br>&gt; I will be glad to put the names of responders in my survey document&#39;s<br>&gt; acknowledgements.<br>&gt;<br>No need.</blockquote>
<div>&nbsp;</div>
<div>I insist. An honor for me. I do not like to show off with someone elses intellect and hardwork.</div><br>&nbsp;</div><br>

------=_Part_8425_7888899.1185918022023--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
