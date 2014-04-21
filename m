Message-ID: <53554FB9.7080502@tycho.nsa.gov>
Date: Mon, 21 Apr 2014 13:04:57 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Kernel freak <kernelfreak@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Allowing access other then permissive mode.
References: <CAOFt0CQHwubzwGSTsw5ig-1tTG9QJe16X5HFoxgjwvV6_StoaA@mail.gmail.com>
 <535516B6.4090705@tycho.nsa.gov>
 <CAOFt0CT+i=A+pvAx+Di2rsTfWBY27A3u-9HR-fxY03jWDYzmLA@mail.gmail.com>
In-Reply-To: <CAOFt0CT+i=A+pvAx+Di2rsTfWBY27A3u-9HR-fxY03jWDYzmLA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/21/2014 12:19 PM, Kernel freak wrote:
> Thank you stephen. But you had also mentioned that security_compute_av()
> are void functions from kernel 3.0, then how is it responsible if access
> is allowed or not. Kindly clarify. Thank you for your time.

Because the caller checks whether the requested permissions are included
in avd->allowed.  The avd structure contains the result of the
security_compute_av() call.
