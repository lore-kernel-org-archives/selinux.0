MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 23 Mar 2015 22:04:24 +0100
From: John Chludzinski <john.chludzinski@vivaldi.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Added project policy code and got =?UTF-8?Q?=22semodule=5Fpac?=
 =?UTF-8?Q?kage=3A=20=20=2E=2E=2E=22?=
In-Reply-To: <551074FD.6030007@tycho.nsa.gov>
References: <fb97f2e61c52ce5eb386dfe0ccd36cae@vivaldi.net>
 <551074FD.6030007@tycho.nsa.gov>
Message-ID: <428423a536216454676cbd6894737f83@vivaldi.net>
Cc: Selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Understood: "Take follow-ups to the clip mailing list, please."

Resolved the problem.

---John


On 2015-03-23 21:18, Stephen Smalley wrote:
> On 03/23/2015 04:12 PM, John Chludzinski wrote:
>> I added project specific policy code to policy/module/<project-dir>.
>> 
>> Then I ran:
>> 
>> packages/clip-selinux-policy/clip-selinux-policy> make conf
>> 
>>>>> "make conf" added all the project module to "module" (e.g., 
>>>>> projmod1
>>>>> = module, projmod2 = module, etc.) in policy/modules.conf.
>> 
>> then I ran:
>> 
>> packages/clip-selinux-policy/clip-selinux-policy> make modules
>> TYPE="mls" MLS_SENS=1
>> 
>> and got "semodule_package:  Failed to mmap tmp/<projmod1>.mod.fc:
>> Invalid argument"
>> 
>> Any suggestions?
> 
> Take follow-ups to the clip mailing list, please.
> 
> http://oss.tresys.com/mailman/listinfo/clip
