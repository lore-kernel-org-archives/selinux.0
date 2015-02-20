Message-ID: <54E769FA.8010801@tycho.nsa.gov>
Date: Fri, 20 Feb 2015 12:08:10 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Tracy Reed <treed@ultraviolet.org>
Subject: Re: MCS error
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <20150219204841.GA1649@linksys-wireless-usb.network2>
 <20150220003425.GF12937@tracyreed.org> <54E738EF.8070601@tycho.nsa.gov>
 <20150220165628.GI12937@tracyreed.org>
In-Reply-To: <20150220165628.GI12937@tracyreed.org>
Content-Type: text/plain; charset=windows-1252
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/20/2015 11:56 AM, Tracy Reed wrote:
> On Fri, Feb 20, 2015 at 05:38:55AM PST, Stephen Smalley spake thusly:
>> Can you show the actual constraints on RHEL6?  seinfo --constrain
>> output, or grab the .src.rpm and pull out the mcs file.
> 
> Here is the seinfo --constrain output from RHEL6. Thanks for having a look!

Sigh. Not preserved in attribute form in that version.  Ok, I grabbed
selinux-policy-3.7.19-231.el6.src.rpm and extracted the mcs file from
it; it has:

mlsconstrain file { read ioctl lock execute execute_no_trans }
        (( h1 dom h2 ) or ( t1 == mcsreadall ) or
        (( t1 != mcsuntrustedproc ) and (t2 == domain)));

which means:

"Only allow read (or the other listed permissions) if the process high
level dominates the file high level or the process type has the
mcsreadall attribute or the process type does not have the
mcsuntrustedproc attribute and the object type has the domain attribute
(i.e. the object is a /proc/pid file)."

So I'm guessing user_t has mcsreadall?  What does seinfo -tuser_t -x |
grep mcs show?
