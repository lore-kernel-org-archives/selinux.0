Subject: Re: libselinux patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20070220150528.49241.qmail@web51504.mail.yahoo.com>
References: <20070220150528.49241.qmail@web51504.mail.yahoo.com>
Content-Type: text/plain
Date: Tue, 20 Feb 2007 10:06:09 -0500
Message-Id: <1171983969.14363.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 07:05 -0800, Steve G wrote:
> >+static int readFD (int fd, char **buf)
> >+{
> >+    char *p;
> >+    size_t size = 16384;
> 
> Why this number? Should it be a define somewhere or based off a kernel parameter?
> 
> +    int s, filesize;
> +
> +    *buf = calloc (16384, sizeof (char));
> 
> Why calloc? Its not as efficient as plain old malloc.
> 
> +    if (*buf == 0)
> +        return -1;
> 
> 0 or NULL? There's a difference on 64 bit machines.
> 
> +
> +    filesize = 0;
> +    do {
> +        p = &(*buf) [filesize];
> +	do {
> +		s = read (fd, p, 16384);
> +	} while (s < 0 && errno == EINTR);
> +        if (s < 0)
> +            break;
> +        filesize += s;
> +        /* only exit for empty reads */
> +        if (s == 0)
> +            break;
> +        size += s;
> +        *buf = realloc (*buf, size);
> 
> So, if you get a short read, why are we playing with memory? This is inefficiant
> for the _normal_ case. The normal case is that you get about 400 bytes for a
> succesful read. I'd say you are better off adjusting the read size on the fly and
> only realloc when you have less that 512 bytes left in the buffer so that there
> is some hysteresis.
> 
> +    } while (1);
> +
> +    if (filesize == 0 && s < 0) {
> +        free (*buf);
> +        *buf = NULL;
> +        return -1;
> +    }
> +
> +    return filesize;
> +}
> +

I also have to wonder whether we'd be better off just switching from
direct open+read of /proc/filesystems to just using fopen+getline,
thereby automatically picking up glibc's internal support of dynamic
buffer allocation and EINTR handling.  Just read the file line-by-line
and bail out if we find selinuxfs or hit the end of file.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
