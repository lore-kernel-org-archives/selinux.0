Subject: Re: setoolsv4: tracking origin of a policy element
To: Elena Reshetova <elena.reshetova@gmail.com>, "SELinux@tycho.nsa.gov"
 <SELinux@tycho.nsa.gov>
References: <CALrft9-5ZFbJgiLZnXoeroAgqhZ+rmzCENXSgdqtyC5+_6pZ-w@mail.gmail.com>
CC: "filippo.bonazzi@aalto.fi" <filippo.bonazzi@aalto.fi>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <562E2796.8000308@tresys.com>
Date: Mon, 26 Oct 2015 09:16:06 -0400
MIME-Version: 1.0
In-Reply-To: <CALrft9-5ZFbJgiLZnXoeroAgqhZ+rmzCENXSgdqtyC5+_6pZ-w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/26/2015 7:20 AM, Elena Reshetova wrote:
> While looking into the policy parser from setools v4, we noticed one
> thing that is missing: origin of a policy element. For example, given a
> certain rule or attribute, it would be great to know in what source file
> it was defined.
> 
> In Android you can find this information by looking at produced
> policy.conf and its comment lines that indicate source file. However I
> don't know if it is the same for desktop selinux policy.
> 
> Would it be acceptable to have this information as part of python class
> representing the parsed policy? It would be really useful for tools like
> policy linter, because it would be very much needed to point to the

That would be acceptable.  Past versions of SETools supported that, but
it has not yet been a priority for v4.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
