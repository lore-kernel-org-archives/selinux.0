Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7LHopCn007483
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 13:50:51 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7LHoIeR004708
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 17:50:18 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7LHoomX003576
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 13:50:50 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n7LHoniY005962
	for <selinux@tycho.nsa.gov>; Fri, 21 Aug 2009 13:50:50 -0400
Message-ID: <4A8EDE77.3050003@redhat.com>
Date: Fri, 21 Aug 2009 13:50:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Semodule syntax is broken.
References: <4A8EC2F9.3040707@redhat.com> <87eir5rv3e.fsf@anzu.internal.golden-gryphon.com>
In-Reply-To: <87eir5rv3e.fsf@anzu.internal.golden-gryphon.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/21/2009 12:27 PM, Manoj Srivastava wrote:
> On Fri, Aug 21 2009, Daniel J Walsh wrote:
> 
>> Currently when rpm ships, it does an 
>> semodule -b base.pp -i a.pp b,pp c.pp
>> It should be able to do 
>> semodule -b base.pp -u a.pp b.pp c.pp
>>
>> But -u blows up if c.pp was not previously installed.  It should
>> follow the rpm -U syntax; upgrade if the previous package exists and
>> install if it does not.  If we want to add a -F (freshen) this could
>> only upgrade pre-existing modules, and ignore others. 
> 
>> If I was to change to -u, I would need to add a fourth field to policy
>> modules and upgrade it each time I added a patch.  It would be a pain,
>> but I guess I could deal with it. 
> 
> 
>> BUT  A bigger problem is how to deal with an administrator that wants
>> to remove a package and ensure it does not get reinstalled.  If an
>> administrator decides he does not want to install unconfined.pp, we do
>> not want an selinux-policy upgrade to re-install the package. 
> 
>         Could you not look at the .pp files already installed, and only
>  add to that list policy  that corresponds to packages currently bing
>  installed in this run of rpm? (Debian has a postinstall script that
>  tries to ma between packages on the system and the corresponding .pp
>  files to be installed). This leaves the heuristics in the packaging
>  scripts, and not in semodule. 
> 
Well that is going to make the packages very complex, also breaks on things like
--force or --oldpackage 

Where if we did a real good job of knowing which package added a pp file.

But I would think the admin would want to prevent any other package from installing the package.

He removed it for a reason.  
>>
>> semodule -r should set a flag when a package gets removed.  Then
>> semodule -u or semodule -i would not install the package unless the
>> administrator specifies a -f.
> 
>> semodule -r unconfined
>> Would create a file in the policy store
>> /etc/selinux/targeted/modules/active/modules/unconfined.exclude.   
> 
>> semodule -u and semodule -i would respect, and just print out an error
>> message. 
>> semodule -u unconfined.pp
>> Warning: unconfined.pp is excluded from the policy store, use -f to
>> force the install 
> 
>         Are you talking about explicit administrator action? In that
>  case it makes sense. 
> 
>         But I would also like to unload policy modules if a package gets
>  removed: So installing, say, apache should also load the selinux policy
>  for apache; and removing the apache package should remove that.
> 
>         But then if I reinstall apache I do not want apache policy from
>  being blocked.
> 
>         So how about asking for semodule -F -r foo 
>  (-F meaning to block the foo.pp from the policy store in the future).
>  This allows the admin to block the policy from the store, but allows
>  normal package removal/reinstall to work nominally.
> 
>> I would like to get consensus on this before I implement.  Or others
>> can implement. 
> 
>         I would like to see a solution that distinguishes between the
>  two use cases, and adds the force option on removal before blocking
>  occurs.
> 
>         manoj

Excellent point, I had not thought of that.  

So proposal

semodule -r : No Change in default behaviour
	 -F : Permanantly removes policy package, leaving POLICY.exclude flag in module store

semodule -u : Install if package not installed, upgrade otherwise)
semodule -f : Only upgrade modules that are currently installed)
semodule -i : No change.
	All will get a warning message if a module they are trying to install has a POLICY.exclude flag
         -q : Shut up Warning messages
         -F : Remove POLICY.exclude flag and install the package

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
