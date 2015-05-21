Message-ID: <555E1DA2.1030606@tycho.nsa.gov>
Date: Thu, 21 May 2015 14:02:10 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov, dac.override@gmail.com
Subject: Re: [PATCH] libselinux: add selinux_openssh_contexts_path()
References: <1432224862-14659-1-git-send-email-plautrba@redhat.com>
 <20150521162441.GB683@x131e> <20150521165322.GD683@x131e>
In-Reply-To: <20150521165322.GD683@x131e>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/21/2015 12:53 PM, Dominick Grift wrote:
> On Thu, May 21, 2015 at 06:24:41PM +0200, Dominick Grift wrote:
>> On Thu, May 21, 2015 at 06:14:22PM +0200, Petr Lautrbach wrote:
>>> openssh in Fedora uses "sshd_net_t" type for privilege separated
>>> processes in the preauthentication phase. Similarly, openssh portable uses
>>> "sftp_t" for internal-sftp processes. Both type are hardcoded what is not ideal.
>>> Therefore selinux_openssh_contexts_path() was created to get a path where sshd
>>> can get a correct types prepared by a distribution or an administrator.
>>
>> I requested this feature and i am using this feature in my personal policy. So hereby my ACK for what it is worth.
>>
>> However:
>>
>> That SYSTEMD_CONTEXTS though, that must have been a mistake?
> 
> As far as i am concerned this commit should be reverted:
> 
> https://github.com/SELinuxProject/selinux/commit/ce2a8848ad45e375cfdb58cebe28bc12431bb3db
> 
> I just did a grep -ri systemd_contexts in the systemd repository and nothing returned. I also cannot place that commit message.
> 
>>
>> I do not believe that this is used or that it is needed/wanted.

We can remove it as a separate change, but only if there are no users,
even in legacy distributions, as otherwise it would be an ABI break.
