Subject: Re: [PATCH] security: Use IS_ENABLED() instead of checking for
 built-in or module
To: Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>
References: <1468512050-26272-1-git-send-email-javier@osg.samsung.com>
 <adc7dca8-9685-c9f0-7d61-d3537963cf6f@schaufler-ca.com>
 <3f0053fa-8824-f86f-e04f-16ad1204abc7@osg.samsung.com>
 <37a0011d-b32f-d24b-3771-f6eb6cae5342@schaufler-ca.com>
 <CAHC9VhSgTSEKhis2j6vBKa1Wejg65BLmMOC40iyCwMWjerV_Xw@mail.gmail.com>
 <4722982b-1541-20f4-c256-68a93dff7cf9@schaufler-ca.com>
 <CAHC9VhTEN_f0SGB652mt3hjB4j_ZD+bXtnuPyMYpwep9pUjo3w@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 James Morris <james.l.morris@oracle.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
Message-ID: <42a51a92-29ac-7ba4-66fb-034f46e90d8e@osg.samsung.com>
Date: Fri, 15 Jul 2016 07:39:29 -0400
MIME-Version: 1.0
In-Reply-To: <CAHC9VhTEN_f0SGB652mt3hjB4j_ZD+bXtnuPyMYpwep9pUjo3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

Hello Paul,

On 07/14/2016 06:06 PM, Paul Moore wrote:

[snip]

> 
> I think it's a reasonable patch and I'm at that point in the day where
> I'm looking for distractions so I just added it to the selinux#next
> queue; once the merge window closes I'll rotate this into my next
> branch.
> 

Great, thanks a lot for your help.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
