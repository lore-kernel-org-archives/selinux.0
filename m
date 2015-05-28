Message-ID: <55676482.6000302@tycho.nsa.gov>
Date: Thu, 28 May 2015 14:54:58 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Ted Toth <txtoth@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: postgresql policy
References: <CAFPpqQH8nFm0YRM-sgQ_8ijmEy6AFiBaU9-71MWRUJ_w0y6L3Q@mail.gmail.com>
In-Reply-To: <CAFPpqQH8nFm0YRM-sgQ_8ijmEy6AFiBaU9-71MWRUJ_w0y6L3Q@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/28/2015 12:52 PM, Ted Toth wrote:
> The ref policy contains a number of sepgsql_ types that are specific
> to the sepgsql postgresql module. The sepgsql module was written to
> support a postgresql security patch that was never accepted by the
> upstream. Now postgresql has gone in a different direction security
> wise adding row level security (RLS). I've been working on developing
> RLS policy to label rows on insert and update and to check access
> perms on select. I've tried using the sepgsql module in the RLS policy
> but have come to the conclusion that because it was not designed for
> this purpose it is not usable. So I'd like to suggest that these types
> be moved out of the postgresql policy possibly into their own module
> although I personally think they have little if any use.

Should probably post a rfc patch to refpolicy list.

On a different note, does this RLS implementation have any SELinux
integration or is it just the typical "let's implement our own custom
policy engine in the database manager and not link it in any way to the
OS security model" approach?  Pity if it is the latter.
