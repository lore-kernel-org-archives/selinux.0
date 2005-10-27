Subject: Re: [PATCH] Sort file contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: SELinux-dev@tresys.com, SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1130356067.7724.6.camel@twoface.columbia.tresys.com>
References: <1130356067.7724.6.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 27 Oct 2005 09:30:29 -0400
Message-Id: <1130419829.18805.192.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-26 at 15:47 -0400, Joshua Brindle wrote:
> This patch changes matchpathcon to sort the file contexts according to a previous email from
> Chris PeBenito:
> 
> ---
> To try to fix this we looked for regular expression sorting algorithms,
> but pretty much came up empty.  So we wrote support/fc_sort.c to do a
> stable sort (merge sort) with this comparison function:
> 
> 1. does one have a meta chars and the other not
> 2. length of the spec up to the first meta char
> 3. length of the entire spec
> 4. does one have a specific file type (--, -d, etc.) and the other not
> ---

I ran setfiles prior to applying this patch to ensure that the
filesystem was labeled consistently with the existing logic, then
applied this patch and ran setfiles -nv.  This reports a variety of
changes in security context (on a rawhide system with strict policy).  A
few examples are below.  I know that we talked about this issue earlier
and plan to insert additional patterns as needed, but it seems that we
need to coordinate that update to file_contexts with this change.
Another issue that occurs to me is whether we want to sort all of the
file contexts (including .homedirs and .local) together, or if we want
to sort them separately and then combine them in a well-defined ordering
(i.e. all local entries are higher precedence than the base).

relabeling /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin from system_u:object_r:bin_t to system_u:object_r:lib_t
relabeling /usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/bin/java from system_u:object_r:java_exec_t to system_u:object_r:lib_t
relabeling /usr/lib/debug/usr/bin from system_u:object_r:bin_t to system_u:object_r:lib_t
relabeling /usr/lib/debug/usr/bin/checkpolicy.debug from system_u:object_r:bin_t to system_u:object_r:lib_t  
relabeling /usr/lib/mozilla-1.7.12/mozilla-xremote-client from system_u:object_r:mozilla_exec_t to system_u:object_r:bin_t
relabeling /usr/lib/openoffice.org2.0/program/libsoffice.so from system_u:object_r:texrel_shlib_t to system_u:object_r:shlib_t


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
