Date: Fri, 5 Sep 2003 10:32:38 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Diyab <diyab@diyab.net>
Cc: Colin Walters <walters@verbum.org>, max barwell <maxb@paradise.net.nz>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: libselinux.so: cannot open shared object file
Message-ID: <20030905003238.GB23799@snoopy.apana.org.au>
References: <1062637188.565.7.camel@orac.lite.net.nz> <1062690102.15712.16.camel@columbia> <3F57A7FA.8050806@diyab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3F57A7FA.8050806@diyab.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 04, 2003 at 05:00:42PM -0400, Diyab wrote:
> >Hm, for some reason the binaries are getting linked against
> >libselinux.so instead of libselinux.so.1.  I'll investigate this.  In
> >the meantime it should be sufficient to install libselinux1-dev. 
> 
> Why not just link libselinux.so to libselinux.so.1 ?  That would at 
> least temporarily fix the problem would it not?

I would assume that this is what the libselinux1-dev package does?
(otherwise that might be the problem).

I haven't seen the packages in question, but what normally happens
(assuming this hasn't changed, I don't think it has):

libselinux.so ---> libselinux.so.1   (symlink, for development)
libselinux.so.1                      (shared library).

You link against libselinux.so; The linker realizes that this points
to libselinux.so.1, and encodes libselinux.so.1 into the resultant
executable (and not libselinux.so).

So you can run the programs with only libselinux.so.1 present, and
libselinux.so is only needed for initial linking.

What is the output of "ldd filename"?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
