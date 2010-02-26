Message-ID: <4B880F0E.2010904@redhat.com>
Date: Fri, 26 Feb 2010 13:12:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <method@manicmethod.com>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: Fixfiles using new setfiles/restorecon simplification
References: <4B85902B.70300@redhat.com> <4B8726DA.8040806@manicmethod.com>	 <4B87CFA0.8030707@redhat.com>	 <1267193425.9997.5.camel@moss-pluto.epoch.ncsc.mil>	 <4B87D94F.1000606@redhat.com> <1267195015.9997.7.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1267195015.9997.7.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------000206020400040703020501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000206020400040703020501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/26/2010 09:36 AM, Stephen Smalley wrote:
> On Fri, 2010-02-26 at 09:23 -0500, Daniel J Walsh wrote:
>    
>> On 02/26/2010 09:10 AM, Stephen Smalley wrote:
>>      
>>> On Fri, 2010-02-26 at 08:41 -0500, Daniel J Walsh wrote:
>>>
>>>        
>>>> On 02/25/2010 08:41 PM, Joshua Brindle wrote:
>>>>
>>>>          
>>>>> What version of the kernel was this added in? I don't want to
>>>>> completely break old kernels using new toolchains (CLIP backports
>>>>> toolchains to RHEL 4 and 5). It would be better to use seclabel if it
>>>>> is there, otherwise fall back to the old list.
>>>>>
>>>>> -- 
>>>>> This message was distributed to subscribers of the selinux mailing list.
>>>>> If you no longer wish to subscribe, send mail to
>>>>> majordomo@tycho.nsa.gov with
>>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>>
>>>>>            
>>>> The problem with this is we end up with a lot of cruft in the toolchain,
>>>> that is continually out of data, and makes it hard to figure out what
>>>> the script is doing.  We have older versions of the tool chain for those
>>>> platforms, shouldn't we have sort of the latest toolchain.
>>>>
>>>>          
>>> If we do that, we ought to make a major bump in the version numbers,
>>> e.g. finally go to 2.1 or 3.0 or something, and make sure the release
>>> announcement clearly marks it as not backward compatible.
>>>
>>> With regard to fixfiles simplification though, can't we eliminate the
>>> need to define or use FILESYSTEMS* altogether in the script by switching
>>> all uses of setfiles to restorecon -R /, since that will automatically
>>> skip non-labeled filesystems on kernels>= 2.6.30?
>>>
>>>
>>>        
>> It will still walk on read/only file systems.
>>      
> That should be fairly easy to fix in setfiles given that we are already
> reading /proc/mounts - we can just add exclude on any ro mounts.
>
>    
How about this patch to remove ro mount points from setfiles/restorecon


--------------000206020400040703020501
Content-Type: text/plain;
 name="policycoreutils-romounts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-romounts.patch"

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 8f4f663..27d52b1 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -186,14 +186,17 @@ static void exclude_non_seclabel_mounts()
 
 		item = strtok(mount_info[3], ",");
 		while (item != NULL) {
+			if (strcmp(item, "ro") == 0) {
+				found = 0;
+				break;
+			}
 			if (strcmp(item, "seclabel") == 0) {
 				found = 1;
-				break;
 			}
 			item = strtok(NULL, ",");
 		}
 
-		/* exclude mount points without the seclabel option */
+		/* exclude ro mount points and those without the seclabel option */
 		if (!found)
 			add_exclude(mount_info[1]);
 	}

--------------000206020400040703020501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
