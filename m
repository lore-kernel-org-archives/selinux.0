Subject: Re: Is it possible to prevent a binary executable file from being
 read via SELinux?
To: Patrick Doyle <wpdster@gmail.com>, selinux@tycho.nsa.gov
References: <CAF_dkJA-3FNQ1m-8AQxrnWXsbiP+P86OUxeXHeRchh3pYZz70g@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <706f5fa7-f73a-641b-2a50-4e58ede933a4@tycho.nsa.gov>
Date: Tue, 1 Nov 2016 15:45:59 -0400
MIME-Version: 1.0
In-Reply-To: <CAF_dkJA-3FNQ1m-8AQxrnWXsbiP+P86OUxeXHeRchh3pYZz70g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/01/2016 11:57 AM, Patrick Doyle wrote:
> Background:
> I have an embedded processor running a custom application on top of
> Linux.  I control the kernel, the rootfs, and the application.  I
> would like to deploy this application such that, if somebody were to
> gain access to my device, even root access, (s)he would not be able to
> read or copy the application from the device.
> 
> I don't know how or if the kernel would even support such a situation
> -- if the executable is not readable, it should not be mappable, and
> therefore the kernel would have a hard time swapping in pages from it.
> So, I recognize that this may be an impossible request.
> 
> But it feels like the sort of thing somebody else should have wondered
> about, and it feels like the sort of thing that SELinux might be able
> to handle.
> 
> Any thoughts or recommendations?
> 
> I asked on IRC, and one person (grist) suggested that perhaps I should
> encrypt the file.  I could do that, but then I find myself in the
> situation of figuring out how to protect the encryption key on the
> device.
> 
> I could implement a TEE (Trusted Execution Environment) on the device
> or attach a TPM (Trusted Platform Module) to protect the key, but
> those approaches add their own complexities.
> 
> Any thoughts or pointers would be gratefully accepted.

Is anything besides your application even running on the device?  Are
there other services/applications that run on the device too?  If not,
then I doubt SELinux or any other access control mechanism is going to
be particularly helpful to you.

When you say "gain access to my device", what kind of access did you
have in mind?  Physical access (if so, then SELinux won't help with
that)?  Remote exploitation of your own application (if so, then
assuming they can do that, they obviously can read out your
application's own memory and SELinux can't prevent that)?  Remote
exploitation of a service or application other than your application
that is running on the device (if so, then yes, Linux DAC and SELinux
can help here)?

You could achieve a degree of protection via Linux DAC by setting the
ownership and mode of the application executable file as restrictively
as possible (it doesn't need to be readable at all, and can be limited
to only being executed by root), by running all other
services/applications in non-root UIDs that differ from the UID in which
your application runs, and by eliminating/minimizing all setuid-root
executables and mounting nosuid where appropriate.

If you can't get rid of root services entirely, then SELinux can extend
this protection to even root processes.  You'd probably want a custom
policy from scratch for that kind of scenario; see the Android policy
for an example.

Obviously this wouldn't help mitigate kernel vulnerabilities or someone
with physical access to the device.
