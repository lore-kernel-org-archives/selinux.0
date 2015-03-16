Message-ID: <5506F0DF.10805@tycho.nsa.gov>
Date: Mon, 16 Mar 2015 11:03:59 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Minear, Spencer" <Spencer_Minear@mcafee.com>,
 "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>
Subject: Re: SE Linux savvy union FS?
References: <81524047c6794563a02a332aef65fd96@MIVEXUSR1N02.corpzone.internalzone.com>
In-Reply-To: <81524047c6794563a02a332aef65fd96@MIVEXUSR1N02.corpzone.internalzone.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/16/2015 10:13 AM, Minear, Spencer wrote:
> I am looking for a union file system that can provide copy on write when
> overlaid on a SE Linux labeled read only  squash file system, that will
> provide the ability to manage the SE Linux file contexts using the same
> rules used when building the original SE Linux labeled squash file system.
> 
>  
> 
> I've found a number of pages on the topic of union file systems related
> to Linux.  However many appear to be out of data and none lead to a
> solution to my question.   I found at least one page that suggests that
> what I'm looking for has been or can be done, but I never found any
> specifics that suggested how to actually do it, and again it may have
> been out of date relative to the facilities that I am using.
> 
>  
> 
> So my questions are:
> 
>  
> 
> 1.       Does this capability exists?
> 
> 2.       Are there some how-to examples that show how to do it?
> 
>  
> 
> FYI, I am using a Debian distribution so information on that
> distribution of Linux would be most useful.
> 
>  
> 
> Thanks for any and all pointers that you may be able to provide.

You might try using overlayfs, as it is in mainline Linux (as of Linux
3.18) and it has logic for copying-up xattrs from the lower filesystem.
 That said, I have not tested it and do not know whether it truly works
well with SELinux.
