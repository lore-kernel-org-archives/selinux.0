MIME-Version: 1.0
In-Reply-To: <1232990837.14213.11.camel@localhost.localdomain>
References: <cadfc0e40901260830u1787249doaeb767d33bba4133@mail.gmail.com>
	 <1232990837.14213.11.camel@localhost.localdomain>
Date: Mon, 26 Jan 2009 13:20:48 -0600
Message-ID: <cadfc0e40901261120n2fd68091t5f5825d81799fc85@mail.gmail.com>
Subject: Re: 3.6.3 policy on fc10 and kerneloops
From: Xavier Toth <txtoth@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jan 26, 2009 at 11:27 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2009-01-26 at 10:30 -0600, Xavier Toth wrote:
>> I've built and install an fc10 version of the rawhide policy and am
>> now getting kerneloops.  Does the kernel build rely on policy files?
>>
>> Kernel failure message 1:
>> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
>> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
>> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
>> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1b6
>> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ff
>> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ed
>> SELinux: WARNING: inside open_file_mask_to_av with unknown mode:c1ed
>
> No, but enabling the openperm policy capability will trigger that
> warning on older kernels.
>
> --
> Stephen Smalley
> National Security Agency
>
>

I'm not familiar with the openperm policy capability how is it enabled/disabled?

Ted

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
