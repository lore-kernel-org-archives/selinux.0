MIME-Version: 1.0
In-Reply-To: <3d207136-9e4a-c61d-7939-2b5a3a7f47a2@tycho.nsa.gov>
References: <CAF_dkJA-3FNQ1m-8AQxrnWXsbiP+P86OUxeXHeRchh3pYZz70g@mail.gmail.com>
 <706f5fa7-f73a-641b-2a50-4e58ede933a4@tycho.nsa.gov>
 <CAF_dkJAW6hyo8r+m=0AuJRkLV4kA_zFM=5tOQd2iWuFHJjb8Pw@mail.gmail.com>
 <3d207136-9e4a-c61d-7939-2b5a3a7f47a2@tycho.nsa.gov>
From: Patrick Doyle <wpdster@gmail.com>
Date: Wed, 2 Nov 2016 09:52:46 -0400
Message-ID: <CAF_dkJDA64AaZBzoC3q0q+9=QPMWy6ju_OL7dK6HDmqtJTZf3g@mail.gmail.com>
Subject: Re: Is it possible to prevent a binary executable file from being
 read via SELinux?
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thank you again.

On Wed, Nov 2, 2016 at 9:25 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> As I said, you can prevent reading of the binary by all other processes
> on the system, but not by the application itself.  The domain in which
> the application runs must be able to read the binary in order to execute
> it as far as SELinux is concerned.  And fundamentally, the running
> application process always has read access to its executable (this may
> change in the future with Intel Memory Protection Keys and execute-only
> memory but that's not reality today).
That makes sense.  I will be running on an ARM architecture, so Intel
Memory Protection Keys won't help :-)

I haven't finished reading the documentation yet, so I don't know the
correct syntax for specifying a policy.  I do know that the SELinux
approach is to disallow everything, except what is explicitly listed
in the policy.  Given that I am interested in starting small, and
achieving this one goal of preventing read access to my application,
would a reasonable custom policy look something like:

Allow all file access to /bin to everybody
Allow all file access to /usr to everybody
Allow all device access to /dev to everybody
etc... (for all of my directories in /... except /opt)
Allow execute file access to /opt/local/myapp to everybody
for /opt/local/myapp allow read access to /opt/local/myapp

Yes, I know this exactly counter to the "dissallow everything, only
allow what you need" mindset.  My hope would be to achieve that
mindset in the end, but as a starting point, and as an exercise in
learning how to speak the policy language, would this be reasonable?

>
> The Android model is to put the init program (which loads the policy)
> and the policy file into the initramfs, and the bootloader verifies the
> signature of the boot image that contains the kernel and the initramfs.
> That's as close we get to baking the policy into the kernel presently.
>
My approach was similar -- except that my whole (tiny) rootfs would be
in the initramfs.  And I guess I would need to ensure that my policy
did not explicitly allow the policy to be changed.

Thanks again for your help.  This is starting to make sense.

--wpd
