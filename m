Subject: Re: Is it possible to prevent a binary executable file from being
 read via SELinux?
To: Patrick Doyle <wpdster@gmail.com>
References: <CAF_dkJA-3FNQ1m-8AQxrnWXsbiP+P86OUxeXHeRchh3pYZz70g@mail.gmail.com>
 <706f5fa7-f73a-641b-2a50-4e58ede933a4@tycho.nsa.gov>
 <CAF_dkJAW6hyo8r+m=0AuJRkLV4kA_zFM=5tOQd2iWuFHJjb8Pw@mail.gmail.com>
 <3d207136-9e4a-c61d-7939-2b5a3a7f47a2@tycho.nsa.gov>
 <CAF_dkJDA64AaZBzoC3q0q+9=QPMWy6ju_OL7dK6HDmqtJTZf3g@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f25bd779-ea07-383e-f724-b86e2847edae@tycho.nsa.gov>
Date: Wed, 2 Nov 2016 10:08:47 -0400
MIME-Version: 1.0
In-Reply-To: <CAF_dkJDA64AaZBzoC3q0q+9=QPMWy6ju_OL7dK6HDmqtJTZf3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/02/2016 09:52 AM, Patrick Doyle wrote:
> I haven't finished reading the documentation yet, so I don't know the
> correct syntax for specifying a policy.  I do know that the SELinux
> approach is to disallow everything, except what is explicitly listed
> in the policy.  Given that I am interested in starting small, and
> achieving this one goal of preventing read access to my application,
> would a reasonable custom policy look something like:
> 
> Allow all file access to /bin to everybody
> Allow all file access to /usr to everybody
> Allow all device access to /dev to everybody
> etc... (for all of my directories in /... except /opt)
> Allow execute file access to /opt/local/myapp to everybody
> for /opt/local/myapp allow read access to /opt/local/myapp
> 
> Yes, I know this exactly counter to the "dissallow everything, only
> allow what you need" mindset.  My hope would be to achieve that
> mindset in the end, but as a starting point, and as an exercise in
> learning how to speak the policy language, would this be reasonable?

No.  For example, if all processes can access all /dev nodes, then they
can perform raw reads/writes to the block devices and thereby circumvent
any file-based access controls entirely.  If all processes can write to
e.g. /lib, then they can replace the dynamic linker and any shared
libraries used by your application and get it to execute their code in
order to dump its memory.  If they can all execute your application,
then they can run its binary in their own memory and then dump its
contents.  Please, see my original email and answer the questions there
(which you mostly ignored) to see whether this is even a worthwhile
exercise, and then, if so, follow the guidance for using sound DAC
ownership and modes first, then investigate SELinux to address residual
gaps.

If you want a simple, small SELinux policy to start from, I would again
recommend the Android SELinux policy.

>> The Android model is to put the init program (which loads the policy)
>> and the policy file into the initramfs, and the bootloader verifies the
>> signature of the boot image that contains the kernel and the initramfs.
>> That's as close we get to baking the policy into the kernel presently.
>>
> My approach was similar -- except that my whole (tiny) rootfs would be
> in the initramfs.  And I guess I would need to ensure that my policy
> did not explicitly allow the policy to be changed.

Yes, that's what Android does too - its rootfs is the initramfs and its
default policy does not allow policy to be reloaded again after the
first load by init.  See its policy for an example.

> Thanks again for your help.  This is starting to make sense.
