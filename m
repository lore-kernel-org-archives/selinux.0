Message-ID: <54E738EF.8070601@tycho.nsa.gov>
Date: Fri, 20 Feb 2015 08:38:55 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tracy Reed <treed@ultraviolet.org>, selinux@tycho.nsa.gov
Subject: Re: MCS error
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <20150219204841.GA1649@linksys-wireless-usb.network2>
 <20150220003425.GF12937@tracyreed.org>
In-Reply-To: <20150220003425.GF12937@tracyreed.org>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/19/2015 07:34 PM, Tracy Reed wrote:
> but when I try to test that it is being MCS restricted nothing gets denied:
> 
> -bash-4.1$ cd /nodes/p16001/
> -bash-4.1$ ls 
> testfile
> -bash-4.1$ 
> -bash-4.1$ id -Z
> p16001_u:user_r:user_t:p16001
> -bash-4.1$ ls -laZ
> drwxr-xr-x. p16001 p16001 user_u:object_r:default_t:p16001 .
> drwxr-xr-x. root   root   system_u:object_r:default_t:SystemLow ..
> -rw-r--r--. p16001 p16001 user_u:object_r:default_t:p16001 testfile
> -bash-4.1$ cat testfile 
> I am 16001
> -bash-4.1$ cd ../p16002/
> -bash-4.1$ ls -laZ
> drwxr-xr-x. p16002 p16002 user_u:object_r:default_t:p16002 .
> drwxr-xr-x. root   root   system_u:object_r:default_t:SystemLow ..
> -rw-r--r--. p16002 p16002 user_u:object_r:default_t:p16002 testfile
> -bash-4.1$ cat testfile 
> I am 16002
> 
> to my understanding user p16001 with only category p16001 should not be able to
> read this file of category p16002.

Can you show the actual constraints on RHEL6?  seinfo --constrain
output, or grab the .src.rpm and pull out the mcs file.
