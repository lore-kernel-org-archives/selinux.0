Subject: Re: Is it possible to prevent a binary executable file from being
 read via SELinux?
To: Patrick Doyle <wpdster@gmail.com>
References: <CAF_dkJA-3FNQ1m-8AQxrnWXsbiP+P86OUxeXHeRchh3pYZz70g@mail.gmail.com>
 <706f5fa7-f73a-641b-2a50-4e58ede933a4@tycho.nsa.gov>
 <CAF_dkJAW6hyo8r+m=0AuJRkLV4kA_zFM=5tOQd2iWuFHJjb8Pw@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3d207136-9e4a-c61d-7939-2b5a3a7f47a2@tycho.nsa.gov>
Date: Wed, 2 Nov 2016 09:25:29 -0400
MIME-Version: 1.0
In-Reply-To: <CAF_dkJAW6hyo8r+m=0AuJRkLV4kA_zFM=5tOQd2iWuFHJjb8Pw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/01/2016 06:41 PM, Patrick Doyle wrote:
> Thank you for your reply.
> 
> On Tue, Nov 1, 2016 at 3:45 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> If you can't get rid of root services entirely, then SELinux can extend
>> this protection to even root processes.  You'd probably want a custom
>> policy from scratch for that kind of scenario; see the Android policy
>> for an example.
> A custom policy is most likely what I want... my question is... can I
> set up such a policy that disallows reading (and, by extension,
> copying) of an executable binary, and yet still be able to execute it?

As I said, you can prevent reading of the binary by all other processes
on the system, but not by the application itself.  The domain in which
the application runs must be able to read the binary in order to execute
it as far as SELinux is concerned.  And fundamentally, the running
application process always has read access to its executable (this may
change in the future with Intel Memory Protection Keys and execute-only
memory but that's not reality today).

>  A related question would be: can I bake that policy immutably into
> the kernel so that it cannot be disabled?  While I can't prevent
> physical access to the device, I can encrypt the kernel & rootfs
> (embedded as a cramfs) as a single binary blob, so I think (hope) that
> is as secure as my encryption key.  I would also do all of the normal
> hardening stuff of disabling loadable modules, shutting down network
> services, etc...

The Android model is to put the init program (which loads the policy)
and the policy file into the initramfs, and the bootloader verifies the
signature of the boot image that contains the kernel and the initramfs.
That's as close we get to baking the policy into the kernel presently.
