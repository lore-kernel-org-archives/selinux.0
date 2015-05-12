Message-ID: <55520757.8080509@tycho.nsa.gov>
Date: Tue, 12 May 2015 09:59:51 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: is_selinux_enabled(): drop no-policy-loaded
 test.
References: <1429278141-7728-1-git-send-email-sds@tycho.nsa.gov>
 <5550B134.6050606@redhat.com> <5550B1FE.5040304@tycho.nsa.gov>
 <5550B368.5020600@redhat.com> <5550B663.1070000@tycho.nsa.gov>
 <5550B6D4.4070002@tycho.nsa.gov> <5550B899.7060603@redhat.com>
 <5550C212.6090702@tycho.nsa.gov> <5551F7F4.5050907@redhat.com>
 <5551F886.40100@tycho.nsa.gov> <55520569.8030306@redhat.com>
In-Reply-To: <55520569.8030306@redhat.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/12/2015 09:51 AM, Petr Lautrbach wrote:
> On 05/12/2015 02:56 PM, Stephen Smalley wrote:
>> BTW, in trying to test these scenarios, I did a yum remove
>> selinux-policy-targeted at one point and was surprised to find that I
>> couldn't subsequently do a yum install selinux-policy-targeted.  It
>> would always fail.  Ultimately I found that if I created an empty
>> /etc/selinux/targeted/contexts/files/file_contexts file and then tried
>> installing it, it would work.  So I guess rpm -i fails if there is no
>> file_contexts file?  That doesn't seem right.
>>
> 
> That's correct. rpm does a verification of a transaction and one of the
> steps is to check files labels. It uses selinux_file_context_path() to
> get a file path and if it can't open this file, it fails as it can't
> confirm whether contexts are ok or not. Empty file_contexts file means
> that there's no conflict.
> 
> If you want to skip this check, you can use:
> 
> rpm -i --nocontexts ...
> or
> yum install --setopt=tsflags=nocontexts
> 
> or just reboot and install selinux-policy-targeted with disabled SELinux.

But it seems wrong that it fails silently, with no indication to the
user what went wrong or how to fix it.

# yum remove selinux-policy-targeted
...
# yum install selinux-policy-targeted
...
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction (shutdown inhibited)
selinux-policy-targeted-3.13.1-105.13.fc21.noarch was supposed to be
installed but is not!
  Verifying  : selinux-policy-targeted-3.13.1-105.13.fc21.noarch
    1/1
  Verifying  : selinux-policy-targeted-3.13.1-105.13.fc21.noarch
    2/1

Failed:
  selinux-policy-targeted.noarch 0:3.13.1-105.13.fc21


Complete!

# yumdownloader selinux-policy-targeted
# rpm -i selinux-policy-targeted-3.13.1-105.13.fc21.noarch.rpm
# echo $?
1
# rpm -q selinux-policy-targeted
package selinux-policy-targeted is not installed
