Message-ID: <553A7050.3050208@tycho.nsa.gov>
Date: Fri, 24 Apr 2015 12:33:20 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Spector, Aaron" <Aaron_Spector@mcafee.com>,
 "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>,
 "Paul Moore (paul@paul-moore.com)" <paul@paul-moore.com>
Subject: Re: Switching to enforcing mode introduces new policy issues?
References: <363d72e72db54ed2a93f39f76d1811fd@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A362B.7040500@tycho.nsa.gov>
 <0787916bff754fec87b219654e47b1e0@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A60D2.30105@tycho.nsa.gov>
 <73c3e069515544578eb3a2798436f272@MIVEXUSR1N01.corpzone.internalzone.com>
 <553A693A.5080807@tycho.nsa.gov> <553A6B3A.70108@tycho.nsa.gov>
 <265314580c2149fca9a8b2d9f9b74592@MIVEXUSR1N01.corpzone.internalzone.com>
In-Reply-To: <265314580c2149fca9a8b2d9f9b74592@MIVEXUSR1N01.corpzone.internalzone.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/24/2015 12:30 PM, Spector, Aaron wrote:
> Correct, I'm not running auditd.
> 
> Is it worth removing the printk_ratelimit call in audit_printk_skb() in audit.c for experimentation purposes? Just let it printk all the audits and if it rolls over, oh well?

Sure.
