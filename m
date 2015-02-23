Message-ID: <54EB3C8B.6050502@tycho.nsa.gov>
Date: Mon, 23 Feb 2015 09:43:23 -0500
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
 <20150220165628.GI12937@tracyreed.org> <54E769FA.8010801@tycho.nsa.gov>
 <54E76FD5.1080905@tycho.nsa.gov> <20150220221056.GL12937@tracyreed.org>
In-Reply-To: <20150220221056.GL12937@tracyreed.org>
Content-Type: text/plain; charset=windows-1252
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/20/2015 05:10 PM, Tracy Reed wrote:
> On Fri, Feb 20, 2015 at 09:33:09AM PST, Stephen Smalley spake thusly:
>> Also, can you confirm that the system is enforcing?  getenforce?
> 
> I should have clarified that the system is in permissive mode but no denials
> were logged in /var/log/audit/audit.log
> 
> [mcstest:/home/users/tracy.reed]# /usr/sbin/sestatus 
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 24
> Policy from config file:        targeted

Hmm...I would check /var/log/messages as well (where denials will be
logged if not running auditd), and re-test in enforcing mode just to be
sure.

Can you send me (not the entire list) your
/etc/selinux/targeted/policy/policy.24 file?
