Message-ID: <54119794.8070902@tycho.nsa.gov>
Date: Thu, 11 Sep 2014 08:37:40 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: "Chengfei (Fixed Network R&D Mgmt Dept)" <chengfei999@huawei.com>,
 "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: Re: Does selinuxfs support ACL?
References: <C4B033C531077E4AA42DB0AE4AE06B581C5A3BEC@szxeml511-mbx.china.huawei.com>
In-Reply-To: <C4B033C531077E4AA42DB0AE4AE06B581C5A3BEC@szxeml511-mbx.china.huawei.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/10/2014 11:21 PM, Chengfei (Fixed Network R&D Mgmt Dept) wrote:
> Hello everyone,
> Recently, I want to make other user use some selinux commands( i.e. setenforce)without using sudo.But , I find the file that /selinux/enforce 's dac-list is -rw-r- -r- - root root which means only root(or set-user-id-root) can use "setenforce 0".So I started to think about apply acl on /selinux/**.
> I used acl like this:
> Mount -t selinuxfs -o remount,acl,rw none /selinux;
> Cat /etc/mtab | grep selinux;//result:seccuss
> So,then:
> Setfacl -m u:newuser:rw /selinux/enforce;//result:failed
> I want to figure out where failed, thanks!:)

No, it does not support ACLs.  You can however chown and chmod it to
permit access by a specific user or group other than root.
