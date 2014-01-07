Message-ID: <52CC2088.8050809@tycho.nsa.gov>
Date: Tue, 07 Jan 2014 10:43:04 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Kernel freak <kernelfreak@gmail.com>
Subject: Re: Allowing all access in SELinux without permissive mode.
References: <CAOFt0CSftkNgEVBaM3Hr6eb+ygYyd2JoSATTir1=EOQy5+uQmA@mail.gmail.com>	<CAFftDdq=R1Ueiz6_SGi0auF0Y8UWUmktNE7Nt8xhtjoUrKX0GQ@mail.gmail.com>	<52CAFC9C.2040708@tycho.nsa.gov>
 <CAOFt0CS+YFG8HVym1rX-aiKs6=nmLWu0FPyb8L25-VyK3FDh2g@mail.gmail.com>
In-Reply-To: <CAOFt0CS+YFG8HVym1rX-aiKs6=nmLWu0FPyb8L25-VyK3FDh2g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "selinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/07/2014 10:06 AM, Kernel freak wrote:
> Hello,
>         Thank you so much for the information. Sorry for the delay in
> replying. I guess I was a bit wrong in understanding the call. What I am
> looking for is the function which decides the access decision regardless
> the policy is loaded or not. So, the function/s where it reads the
> policy file, and depending upon the rule from the policy file returns
> the decision and logs that decision in AVC. I would not like to use
> permissive mode for this as I am searching for the way access decisions
> are made in SELinux. As Security Server(ss) is responsible for relaying
> the access decisions and not enforcing them, I was searching for them in
> ss. Kindly point me if I am thinking in a wrong manner. Thank you so
> much for your time.

The policy is loaded into internal data structures during system
initialization (see security_load_policy and the functions it calls),
and the security server consults those data structures (see
security_compute_av and the functions it calls) to compute the allowed
permissions.  The decisions are stored in the avd (struct av_decision)
returned by the security server to the AVC.  You can trace through the
code, or read English descriptions in:
http://www.freetechbooks.com/the-selinux-notebook-the-foundations-t785.html
https://www.imperialviolet.org/2009/07/14/selinux.html
http://www.nsa.gov/research/_files/selinux/papers/slinux-abs.shtml

Obviously some of these references are quite out of date but can still
be helpful in understanding the overall structure and flow.

> Question to mailing list head : While replying to mails in mailing list,
> should the email reply of people who replied me already be included or
> not? Thank you.

You can infer it from the way I responded to your email; include the
_relevant_ portions of the message to which you are responding, and
"bottom posting" rather than "top posting" is preferred.  However, this
is increasingly counter to the defaults of modern email clients and
therefore you will see mixed practice, even by me.
