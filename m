Message-ID: <1493988489.5745.1.camel@tycho.nsa.gov>
Subject: Re: Full SELinux labels on loopback for UDP
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
Date: Fri, 05 May 2017 08:48:09 -0400
In-Reply-To: <ae25c71e-96a8-b83f-263c-feccc34bf02f@schaufler-ca.com>
References: <ae25c71e-96a8-b83f-263c-feccc34bf02f@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-05-04 at 15:27 -0700, Casey Schaufler wrote:
> Grubbing about in the SELinux netlabel code leads
> me to ask how one would go about testing that the
> local loopback (tag 6) CIPSO implementation works
> for UDP. I can readily see how it all works for TCP.
> Since I can't see how it works for UDP, I'd like to
> have a test I can use to convince myself that it
> does indeed work.

selinux-testsuite tests it.  You can just run it in the usual manner.
If you want to do it by hand, then you can do the following:

# cd selinux-testsuite/tests/inet_socket
# make
# ./cipso-fl-load
# ./server dgram 666 &
# ./client dgram 127.0.0.1 666
./server: Got SCM_SECURITY=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
# killall server
# ./cipso-fl-flush
