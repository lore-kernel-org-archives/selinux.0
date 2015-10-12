Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9CCTNOr022673
 for <selinux@tycho.nsa.gov>; Mon, 12 Oct 2015 08:29:23 -0400
Date: Mon, 12 Oct 2015 12:26:21 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <1884047573.3637566.1444652781647.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <56181972.8000901@tycho.nsa.gov>
References: <56181972.8000901@tycho.nsa.gov>
Subject: Re: [RFC PATCH V3] libselinux: Add selabel_digest function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>






> On Friday, 9 October 2015, 20:46, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 09/30/2015 11:29 AM, Richard Haines wrote:
>>  selabel_digest(3) if enabled by the SELABEL_OPT_DIGEST option during
>>  selabel_open(3) will return an SHA1 digest of the spec files, plus
>>  a list of the specfiles used to calculate the digest. There is a
>>  test utility supplied that will demonstrate the functionality.
>> 
>>  The use case for selabel_digest(3) is to implement an selinux_restorecon
>>  function based on the Android version that writes a hash of the
>>  file_contexts files to an extended attribute to enhance performance
>>  (see external/libselinux/src/android.c selinux_android_restorecon()).
>> 
>>  Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> 
> Seems sane to me.  Is there a reason it is still an RFC?

> 

No - Would you like it submitted without the RFC

>>  ---
>>  V2 Changes:
>>  Minor general cleanups and updated as per comments from:
>>  http://marc.info/?l=selinux&m=144233357510422&w=2
>>  V3 Changes:
>>  As per comments from: 

> http://marc.info/?l=selinux&m=144355202127208&w=2
