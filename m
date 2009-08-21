Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7LGfq3T031276
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 12:41:52 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7LGfJeR014226
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 16:41:19 GMT
Received: from anzu.internal.golden-gryphon.com (tiamat.golden-gryphon.com [204.117.95.118])
	(authenticated bits=128)
	by ladon.golden-gryphon.com (8.14.3/8.14.3/Debian-5) with ESMTP id n7LGYhlm032367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 11:34:44 -0500
Received: from anzu.internal.golden-gryphon.com.internal.golden-gryphon.com (localhost [127.0.0.1])
	by anzu.internal.golden-gryphon.com (8.14.3/8.14.3/Debian-9) with ESMTP id n7LGR1Oc030028
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 11:27:01 -0500
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Subject: Re: Semodule syntax is broken.
References: <4A8EC2F9.3040707@redhat.com>
Date: Fri, 21 Aug 2009 11:27:01 -0500
In-Reply-To: <4A8EC2F9.3040707@redhat.com> (Daniel J. Walsh's message of "Fri,
	21 Aug 2009 11:53:29 -0400")
Message-ID: <87eir5rv3e.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Aug 21 2009, Daniel J Walsh wrote:

> Currently when rpm ships, it does an 
> semodule -b base.pp -i a.pp b,pp c.pp
> It should be able to do 
> semodule -b base.pp -u a.pp b.pp c.pp
>
> But -u blows up if c.pp was not previously installed.  It should
> follow the rpm -U syntax; upgrade if the previous package exists and
> install if it does not.  If we want to add a -F (freshen) this could
> only upgrade pre-existing modules, and ignore others. 

> If I was to change to -u, I would need to add a fourth field to policy
> modules and upgrade it each time I added a patch.  It would be a pain,
> but I guess I could deal with it. 


> BUT  A bigger problem is how to deal with an administrator that wants
> to remove a package and ensure it does not get reinstalled.  If an
> administrator decides he does not want to install unconfined.pp, we do
> not want an selinux-policy upgrade to re-install the package. 

        Could you not look at the .pp files already installed, and only
 add to that list policy  that corresponds to packages currently bing
 installed in this run of rpm? (Debian has a postinstall script that
 tries to ma between packages on the system and the corresponding .pp
 files to be installed). This leaves the heuristics in the packaging
 scripts, and not in semodule. 

>
> semodule -r should set a flag when a package gets removed.  Then
> semodule -u or semodule -i would not install the package unless the
> administrator specifies a -f.

> semodule -r unconfined
> Would create a file in the policy store
> /etc/selinux/targeted/modules/active/modules/unconfined.exclude.   

> semodule -u and semodule -i would respect, and just print out an error
> message. 
> semodule -u unconfined.pp
> Warning: unconfined.pp is excluded from the policy store, use -f to
> force the install 

        Are you talking about explicit administrator action? In that
 case it makes sense. 

        But I would also like to unload policy modules if a package gets
 removed: So installing, say, apache should also load the selinux policy
 for apache; and removing the apache package should remove that.

        But then if I reinstall apache I do not want apache policy from
 being blocked.

        So how about asking for semodule -F -r foo 
 (-F meaning to block the foo.pp from the policy store in the future).
 This allows the admin to block the policy from the store, but allows
 normal package removal/reinstall to work nominally.

> I would like to get consensus on this before I implement.  Or others
> can implement. 

        I would like to see a solution that distinguishes between the
 two use cases, and adds the force option on removal before blocking
 occurs.

        manoj
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
