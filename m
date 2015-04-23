Message-ID: <5538E5B4.3000604@tycho.nsa.gov>
Date: Thu, 23 Apr 2015 08:29:40 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Minear, Spencer" <Spencer_Minear@mcafee.com>,
 "SELinux (selinux@tycho.nsa.gov)" <selinux@tycho.nsa.gov>
Subject: Re: Yet another strange behavior.
References: <a8fc1b0fbe484a1596e07221e7c5424e@MIVEXUSR1N02.corpzone.internalzone.com>
In-Reply-To: <a8fc1b0fbe484a1596e07221e7c5424e@MIVEXUSR1N02.corpzone.internalzone.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/22/2015 06:01 PM, Minear, Spencer wrote:
> I will state up front I'm not expecting a concrete answer for this one,  but I sure would appreciate knowing if others may have ever seen a strange behavior as I'll try to describe below.   It has the feeling of some strange timing window, but even that explanation seems a bit far-fetched.
> 
> For context, I have a Debian based with some number of differences from "standard Debian".  I have a policy that I know gets loaded by the init process, and that shortly after the policy is loaded that an init driven script is run that mounts a non-root ext3 file system.  That same file system was mounted in previous runs of the system and it was labeled in agreement with the current policy during a previous boot of the system.  About a half second after the ext3  file system is mounted, another init initiated activity is run that uses the -i option on a run of the sed command which thus creates a temporary file to capture the changes and at the end of the run it will be renamed to the original input file.
> 
> I run this same installation image and the same policy on 3 different systems, all virtual machines of one type or another.  On one of these systems starting with the third reboot I will see and policy violation audit saying that the process running the sed program does not have create permission to the a file that happens to have the same context as the file on which the sed program is run.
> 
> On the other two systems I can reboot over and over never see the audit. 
> 
> When I use sesearch on the policy file on the system that generated the audit, it reports that the type of the process clearly has create permission to a file of the type being created. At least based on target type provided in the audit message.
> 
> The audit is being generated a full half second after the file system mount is completed and 1.8 seconds after the policy load audit is generated.
> 
> I can manually run the same init startup action and I do not see the problem.
> 
> I am very confident that the policy, as loaded by init at boot time, is the same every time since it exists in a Read Only file system image that is not changed in this test sequence.

Could the denial be due to something other than TE rules, e.g. based on
the user identity or level of the file in question?  What's the actual
avc denial?
