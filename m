Subject: Re: Selectively assigning SELinux policies to permissive and
 enforcement mode
To: Taeho Kgil <taeho.kgil@gmail.com>, selinux@tycho.nsa.gov
References: <CAEe7Eb1Mo0FSHkrHZxM1s0z3ckOBfuahhak4HakoDdtGUFd9vQ@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <525a0ff1-ac22-286a-3f2b-e5c38168c5fc@tycho.nsa.gov>
Date: Mon, 20 Jun 2016 08:54:24 -0400
MIME-Version: 1.0
In-Reply-To: <CAEe7Eb1Mo0FSHkrHZxM1s0z3ckOBfuahhak4HakoDdtGUFd9vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/19/2016 07:16 PM, Taeho Kgil wrote:
> Hi SELinux community, 
> 
> I'm relatively new to this mailing list and not sure if this is the
> appropriate place to raise this question. 
> 
> I am trying to see if we can selectively assign policies to permissive
> and enforcement. Is this a possible capability available today?

Yes, SELinux permissive domains allow you to do this.  On Linux
distributions, you can configure specific domains to be permissive via
the semanage permissive command, see:
https://selinuxproject.org/page/PermissiveDomainRecipe

On Android, you can achieve the same effect by adding a permissive
declaration for the domain to the corresponding .te file under
external/sepolicy (or system/sepolicy in master) or your
device/<vendor>/<product>/sepolicy directory, and then rebuilding your
image.  Of course, for your final production image, there must not be
any permissive domains, or it will fail the CTS.
