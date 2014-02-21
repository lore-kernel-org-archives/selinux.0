Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1LCRkmZ004582
 for <selinux@tycho.nsa.gov>; Fri, 21 Feb 2014 07:27:46 -0500
References: <1392391214-14547-1-git-send-email-richard_c_haines@btinternet.com>
 <1392556690.15615.97.camel@deadeye.wl.decadent.org.uk>
Message-ID: <1392985663.86285.YahooMailNeo@web87903.mail.ir2.yahoo.com>
Date: Fri, 21 Feb 2014 12:27:43 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH] ss: Add support for retrieving SELinux contexts
To: Ben Hutchings <ben@decadent.org.uk>
In-Reply-To: <1392556690.15615.97.camel@deadeye.wl.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I've updated the patch with your suggestions and rebuild using the latest git
repository. Will send V2 patch today.

Thanks
Richard



----- Original Message -----
> From: Ben Hutchings <ben@decadent.org.uk>
> To: Richard Haines <richard_c_haines@btinternet.com>
> Cc: netdev@vger.kernel.org; selinux@tycho.nsa.gov
> Sent: Sunday, 16 February 2014, 13:18
> Subject: Re: [PATCH] ss: Add support for retrieving SELinux contexts
> 
> On Fri, 2014-02-14 at 15:20 +0000, Richard Haines wrote:
>>  The process SELinux contexts can be added to the output using the -Z
>>  option. Using the -z option will show the process and socket contexts (see
>>  the man page for details).
>>  For netlink sockets: if valid process show process context, if pid = 0
>>  show kernel initial context, if unknown show "not available".
>> 
>>  Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>  ---
>>   configure     |  16 +++
>>   man/man8/ss.8 |  34 ++++++
>>   misc/Makefile |  12 ++
>>   misc/ss.c     | 375 
> ++++++++++++++++++++++++++++++++++++++++++++++++++--------
>>   4 files changed, 387 insertions(+), 50 deletions(-)
>> 
>>  diff --git a/configure b/configure
>>  index da01c19..854837e 100755
>>  --- a/configure
>>  +++ b/configure
>>  @@ -231,6 +231,19 @@ EOF
>>       rm -f $TMPDIR/ipsettest.c $TMPDIR/ipsettest
>>   }
>>   
>>  +check_selinux()
>>  +# SELinux is a compile time option in the ss utility
>>  +{
>>  +    SELINUX_LIB=$(${PKG_CONFIG} --silence-errors libselinux --libs)
>>  +    if [ -n "$SELINUX_LIB" ]
> 
> This should be just:
>     if pkg-config libselinux --exists
> 
>>  +    then
>>  +    echo "HAVE_SELINUX:=y" >>Config
>>  +    echo "yes"
>>  +    else
>>  +    echo "no"
>>  +    fi
>>  +}
> [...]
>>  --- a/misc/Makefile
>>  +++ b/misc/Makefile
>>  @@ -8,6 +8,18 @@ include ../Config
>>   all: $(TARGETS)
>>   
>>   ss: $(SSOBJ)
>>  +ifeq ($(HAVE_SELINUX),y)
>>  +    $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SSOBJ) $(LDLIBS) -lselinux
> 
> This should use the output of 'pkg-config libselinux --libs'.
> 
>>  +else
>>  +    $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SSOBJ) $(LDLIBS)
>>  +endif
>>  +
>>  +ss.o: ss.c
>>  +ifeq ($(HAVE_SELINUX),y)
>>  +    $(CC) $(CFLAGS) -DHAVE_SELINUX -c $+
> 
> This should use the output of 'pkg-config libselinux --cflags'.
> 
>>  +else
>>  +    $(CC) $(CFLAGS) -c $+
>>  +endif
> [...]
> 
> Ben.
> 
> -- 
> Ben Hutchings
> Any sufficiently advanced bug is indistinguishable from a feature.
> 
