Message-ID: <546A1634.1070900@tycho.nsa.gov>
Date: Mon, 17 Nov 2014 10:37:24 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Paddie O'Brien" <paddieobrien@gmail.com>, Selinux@tycho.nsa.gov
Subject: Re: Question on unconfined_t
References: <CAOK12DaUYM-Pq5d8E0CGyLZTz_+ihOBF6hPUbp7hh20OuQEi+w@mail.gmail.com>
In-Reply-To: <CAOK12DaUYM-Pq5d8E0CGyLZTz_+ihOBF6hPUbp7hh20OuQEi+w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/17/2014 09:44 AM, Paddie O'Brien wrote:
> Hi,
> 
> As a learning exercise I created a simple policy to sandbox a simple
> program in its own domain.
> 
> I had to add rules to the policy to allow the program to be executed
> from unconfined_t. Is this normal? My understanding was that a process
> in unconfined_t was subject only to DAC so why did I have to add this
> rule? What does unconfined_t actually mean?

SELinux has no intrinsic concept of unconfined_t; unconfined_t is just a
type that is allowed to do most things by policy.
