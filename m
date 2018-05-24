To: shagun maheshwari <shagunmaheshwariitmec@gmail.com>, selinux@tycho.nsa.gov
References: <CAMYJFZ9V2stVKHZVuS0OqRTqk-iUXAZRzrys1oULDdV_mGi5wg@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8cc9c7a2-2768-7381-5905-8c78ab76cee6@tycho.nsa.gov>
Date: Thu, 24 May 2018 08:28:38 -0400
MIME-Version: 1.0
In-Reply-To: <CAMYJFZ9V2stVKHZVuS0OqRTqk-iUXAZRzrys1oULDdV_mGi5wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: Selinux load_policy command on inactive partition is loading
 policy on active partition
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/24/2018 01:48 AM, shagun maheshwari wrote:
> Hi,
> 
> We have done changes in our Centos7.4 to disable the unconfined user from our code. We have created an iso in which we have replaced unconfined with sysadm and we are performing an upgrade using the new iso. 
> After upgrade current partition stop working. It started expecting policies for unconfined when we perform reboot things started working fine again. 
> We are suspecting some issues with this command "load_policy -qi" when this command is being executed on partB in permissive mode and after we move the system to enforcing mode. It starts giving denials for unconfined. 
> 
> Can you explain what exactly load_policy do? 
> Does it load the policies for all the partitions of the system?

load_policy always loads the active system policy as defined by /etc/selinux/config.  If you want it to load a policy from another partition you need to run it under chroot or a filesystem namespace such that it uses /etc/selinux from the other partition.  It only loads one policy though, not multiple.
