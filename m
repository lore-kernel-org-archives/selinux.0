Message-ID: <1400252744.444.12.camel@x220.localdomain>
Subject: Re: secilc: classmappings do not work
From: Dominick Grift <dominick.grift@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Date: Fri, 16 May 2014 17:05:44 +0200
In-Reply-To: <53761EB7.5060906@tycho.nsa.gov>
References: <1400242442.444.9.camel@x220.localdomain>
 <53761EB7.5060906@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2014-05-16 at 10:20 -0400, James Carter wrote:
> On 05/16/2014 08:14 AM, Dominick Grift wrote:
> > I wanted to try out some of the less common features of cil after
> > studying the cil reference guide but its been a bumpy ride.
> >
> > Anyhow classmappings do not work
> >
> > I have for example this one
> >
> > (clasmap dirs (list))
> >
> > (classmapping dirs list
> >      read_lnk_file_perms
> >      list_dir_perms
> > )
> >
> > The read_lnk_file_perms and list_dir_perms are classpermissionsets
> > (which work nicely)
> >
> > Only the first entry works (in this example read_lnk_file_perms)
> > The other entries (like in this example list_dir_perms) do not make it
> > to the resulting policy
> >
> > I have also tried this with straight rules instead of
> > classpermissionsets (same result)
> >
> 
> It will work if it is written as:
> 
> (classmapping dirs list
>        ((read_lnk_file_perms)
>        (list_dir_perms))
> )
> 
> There is a bit of awkwardness to lists of class-permissions. All of the 
> following are acceptable:
> 
> 1. SETNAME
> 2. (CLASS (PERM1 PERM2 ...))
> 3. ((CLASS (PERM1 PERM2 ...)) (SETNAME) ...)
> 
> We allow case 2 because it is the common case for allow rules, but because of 
> case 2, if you have more than a single class-permission, everything must be 
> enclosed in parenthesis.
> 
> We are planning to change the syntax, but I haven't gotten around to doing it yet.
> 
> The new syntax would only allow cases 1 and 2. If you want to assign more than 
> one class-permission to a classmap, classpermissionset, or rule you would just 
> use multiple rules.
> 
> So your classmapping would be:
> 
> (classmapping dirs list
>        read_lnk_file_perms
> )
> 
> (classmapping dirs list
>        list_dir_perms
> )
> 
> Would this new syntax make more sense to you?

Yes i suppose it would as i actually wanted to try that (eventually i
did not bother to try it though since i just trusted the cil reference
guide which made no mention of it.

For now i will try the temporary solution with the extra parens, and
make a note to adjust as soon as a more permanent solution becomes
available
