Subject: Re: 3.6.3 policy on fc10 and kerneloops
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Xavier Toth <txtoth@gmail.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <cadfc0e40901261120n2fd68091t5f5825d81799fc85@mail.gmail.com>
References: <cadfc0e40901260830u1787249doaeb767d33bba4133@mail.gmail.com>
	 <1232990837.14213.11.camel@localhost.localdomain>
	 <cadfc0e40901261120n2fd68091t5f5825d81799fc85@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 26 Jan 2009 14:23:15 -0500
Message-Id: <1232997795.14213.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2009-01-26 at 13:20 -0600, Xavier Toth wrote:
> On Mon, Jan 26, 2009 at 11:27 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Mon, 2009-01-26 at 10:30 -0600, Xavier Toth wrote:
> >> I've built and install an fc10 version of the rawhide policy and am
> >> now getting kerneloops.  Does the kernel build rely on policy files?
> >>
> >> Kernel failure message 1:
> >> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
> >> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
> >> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
> >> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1b6
> >> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
> >> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ed
> >> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ed
> >
> > No, but enabling the openperm policy capability will trigger that
> > warning on older kernels.
> >
> > --
> > Stephen Smalley
> > National Security Agency
> >
> >
> 
> I'm not familiar with the openperm policy capability how is it enabled/disabled?

The policy/policy_capabilities file specifies what policy capabilities
are enabled for a given policy - that tells the kernel whether or not to
enable newer permission checks that require a newer policy.  Originally
introduced for the network peer controls and then extended for the new
open permission check.

You have to modify that file and then rebuild the base module.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
