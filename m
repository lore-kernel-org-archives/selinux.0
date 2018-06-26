To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
References: <20180618172201.4540-1-vmojzis@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7a86ce5a-5141-c708-5c19-271086f4f873@tycho.nsa.gov>
Date: Tue, 26 Jun 2018 09:54:05 -0400
MIME-Version: 1.0
In-Reply-To: <20180618172201.4540-1-vmojzis@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] python/semanage: Stop logging loginRecords changes
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/18/2018 01:22 PM, Vit Mojzis wrote:
> semanage_seuser_modify_local and semanage_seuser_del_local already do
> the logging.
> Moreover, semanage log for loginRecords.__add was flawed since it
> reported old-{seuser,role,range} of default user instead of None. This
> was caused by selinux.getseuserbyname, which returns values for default
> user when the specified username is not found.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1294663

Thanks, applied.

> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
> ---
>  python/semanage/seobject.py | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index c76dce85..d3e14a8b 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -593,7 +593,6 @@ class loginRecords(semanageRecords):
>  
>          semanage_seuser_key_free(k)
>          semanage_seuser_free(u)
> -        self.mylog.log("login", name, sename=sename, serange=serange, serole=",".join(serole), oldserole=",".join(oldserole), oldsename=self.oldsename, oldserange=self.oldserange)
>  
>      def add(self, name, sename, serange):
>          try:
> @@ -601,7 +600,6 @@ class loginRecords(semanageRecords):
>              self.__add(name, sename, serange)
>              self.commit()
>          except ValueError as error:
> -            self.mylog.commit(0)
>              raise error
>  
>      def __modify(self, name, sename="", serange=""):
> @@ -653,7 +651,6 @@ class loginRecords(semanageRecords):
>  
>          semanage_seuser_key_free(k)
>          semanage_seuser_free(u)
> -        self.mylog.log("login", name, sename=self.sename, serange=self.serange, serole=",".join(serole), oldserole=",".join(oldserole), oldsename=self.oldsename, oldserange=self.oldserange)
>  
>      def modify(self, name, sename="", serange=""):
>          try:
> @@ -661,7 +658,6 @@ class loginRecords(semanageRecords):
>              self.__modify(name, sename, serange)
>              self.commit()
>          except ValueError as error:
> -            self.mylog.commit(0)
>              raise error
>  
>      def __delete(self, name):
> @@ -694,8 +690,6 @@ class loginRecords(semanageRecords):
>          rec, self.sename, self.serange = selinux.getseuserbyname("__default__")
>          range, (rc, serole) = userrec.get(self.sename)
>  
> -        self.mylog.log_remove("login", name, sename=self.sename, serange=self.serange, serole=",".join(serole), oldserole=",".join(oldserole), oldsename=self.oldsename, oldserange=self.oldserange)
> -
>      def delete(self, name):
>          try:
>              self.begin()
> @@ -703,7 +697,6 @@ class loginRecords(semanageRecords):
>              self.commit()
>  
>          except ValueError as error:
> -            self.mylog.commit(0)
>              raise error
>  
>      def deleteall(self):
> @@ -717,7 +710,6 @@ class loginRecords(semanageRecords):
>                  self.__delete(semanage_seuser_get_name(u))
>              self.commit()
>          except ValueError as error:
> -            self.mylog.commit(0)
>              raise error
>  
>      def get_all_logins(self):
> 
